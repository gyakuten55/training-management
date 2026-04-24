"use client";

import { useEffect, useState } from "react";
import { createClient } from "@/lib/supabase";
import { cn } from "@/lib/utils";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import Link from "next/link";
import { ORDER_STATUS_LABELS, STATUS_COLORS } from "@/lib/types";
import type { Order, Client, TrainingSession } from "@/lib/types";

interface OrderWithClient extends Order {
  client: Client;
}

export default function DashboardPage() {
  const [orders, setOrders] = useState<OrderWithClient[]>([]);
  const [upcomingSessions, setUpcomingSessions] = useState<
    (TrainingSession & { training_program: { order: { client: Client } } })[]
  >([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    async function loadData() {
      const { data: ordersData } = await supabase
        .from("orders")
        .select("*, client:clients(*)")
        .order("updated_at", { ascending: false });

      if (ordersData) setOrders(ordersData as OrderWithClient[]);

      const today = new Date().toISOString().split("T")[0];
      const nextWeek = new Date(Date.now() + 14 * 86400000)
        .toISOString()
        .split("T")[0];

      const { data: sessionsData } = await supabase
        .from("training_sessions")
        .select(
          "*, training_program:training_programs(*, order:orders(*, client:clients(*)))"
        )
        .gte("session_date", today)
        .lte("session_date", nextWeek)
        .order("session_date", { ascending: true });

      if (sessionsData) setUpcomingSessions(sessionsData as never[]);
      setLoading(false);
    }
    loadData();
  }, [supabase]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground text-sm">読み込み中...</p>
      </div>
    );
  }

  const activeOrders = orders.filter(
    (o) => !["完了", "中止", "失注"].includes(o.status)
  );
  const completedCount = orders.filter((o) => o.status === "完了").length;
  const cancelledCount = orders.filter(
    (o) => o.status === "中止" || o.status === "失注"
  ).length;

  const upcomingActions = activeOrders
    .filter((o) => o.next_action_date)
    .sort(
      (a, b) =>
        new Date(a.next_action_date!).getTime() -
        new Date(b.next_action_date!).getTime()
    )
    .slice(0, 10);

  const billingAlerts = orders.filter(
    (o) =>
      o.billing_status === "未請求" &&
      !["中止", "失注"].includes(o.status) &&
      parseInt(o.status) >= 10
  );

  return (
    <div className="space-y-6">
      <h2 className="text-lg font-semibold">ダッシュボード</h2>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="pb-1">
            <CardTitle className="text-xs font-normal text-muted-foreground">
              進行中
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-semibold">{activeOrders.length}</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-1">
            <CardTitle className="text-xs font-normal text-muted-foreground">
              完了
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-semibold">{completedCount}</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-1">
            <CardTitle className="text-xs font-normal text-muted-foreground">
              中止・失注
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-semibold text-muted-foreground">{cancelledCount}</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-1">
            <CardTitle className="text-xs font-normal text-muted-foreground">
              直近の研修予定
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-semibold">{upcomingSessions.length}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium">ネクストアクション</CardTitle>
          </CardHeader>
          <CardContent>
            {upcomingActions.length === 0 ? (
              <p className="text-muted-foreground text-sm">なし</p>
            ) : (
              <div className="divide-y">
                {upcomingActions.map((order) => (
                  <Link
                    key={order.id}
                    href={`/orders/${order.id}`}
                    className="flex items-center justify-between py-2.5 hover:bg-muted/50 -mx-2 px-2 rounded transition-colors"
                  >
                    <div>
                      <p className="text-sm">{order.client?.name}</p>
                      <p className="text-xs text-muted-foreground">
                        {order.next_action_memo || ORDER_STATUS_LABELS[order.status]}
                      </p>
                    </div>
                    <div className="text-right shrink-0 ml-4">
                      <p className="text-xs text-muted-foreground">{order.next_action_date}</p>
                      <Badge
                        variant="secondary"
                        className={cn(STATUS_COLORS[order.status] || "", "text-[11px]")}
                      >
                        {ORDER_STATUS_LABELS[order.status]}
                      </Badge>
                    </div>
                  </Link>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium">今後2週間の研修予定</CardTitle>
          </CardHeader>
          <CardContent>
            {upcomingSessions.length === 0 ? (
              <p className="text-muted-foreground text-sm">なし</p>
            ) : (
              <div className="divide-y">
                {upcomingSessions.map((session) => (
                  <div
                    key={session.id}
                    className="flex items-center justify-between py-2.5"
                  >
                    <div>
                      <p className="text-sm">
                        {(session.training_program as never as { order: { client: Client } })?.order?.client?.name}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {session.day_number}日目 / {session.instructor || "未定"}
                      </p>
                    </div>
                    <div className="text-right shrink-0 ml-4">
                      <p className="text-sm">{session.session_date}</p>
                      <p className="text-xs text-muted-foreground">
                        {session.start_time} - {session.end_time}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        {billingAlerts.length > 0 && (
          <Card className="lg:col-span-2">
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium">請求対応が必要</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="divide-y">
                {billingAlerts.map((order) => (
                  <Link
                    key={order.id}
                    href={`/orders/${order.id}`}
                    className="flex items-center justify-between py-2.5 hover:bg-muted/50 -mx-2 px-2 rounded transition-colors"
                  >
                    <div className="flex items-center gap-3">
                      <p className="text-sm">{order.client?.name}</p>
                      <Badge
                        variant="secondary"
                        className={cn(STATUS_COLORS[order.status] || "", "text-[11px]")}
                      >
                        {ORDER_STATUS_LABELS[order.status]}
                      </Badge>
                    </div>
                    <span className="text-xs text-muted-foreground">未請求</span>
                  </Link>
                ))}
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}
