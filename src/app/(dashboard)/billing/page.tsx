"use client";

import { useEffect, useState, useMemo } from "react";
import { createClient } from "@/lib/supabase";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ORDER_STATUS_LABELS, STATUS_COLORS } from "@/lib/types";
import type { Order, Client, OrderStatus } from "@/lib/types";
import Link from "next/link";
import { cn } from "@/lib/utils";

interface OrderWithClient extends Order {
  client: Client;
}

type SortKey =
  | "client_name"
  | "status"
  | "order_amount"
  | "billing_date"
  | "billing_status"
  | "subsidy_status";
type SortDir = "asc" | "desc";

function billingSortValue(s: string): number {
  switch (s) {
    case "未請求": return 0;
    case "請求済": return 1;
    case "入金済": return 2;
    default: return -1;
  }
}

function subsidySortValue(s: string): number {
  switch (s) {
    case "未申請": return 0;
    case "計画届提出済": return 1;
    case "申請提出済": return 2;
    case "支給決定": return 3;
    case "完了": return 4;
    default: return -1;
  }
}

function statusSortValue(s: string): number {
  if (s === "完了") return 100;
  if (s === "中止") return 101;
  if (s === "失注") return 102;
  const n = parseInt(s);
  return isNaN(n) ? 50 : n;
}

export default function BillingPage() {
  const [orders, setOrders] = useState<OrderWithClient[]>([]);
  const [loading, setLoading] = useState(true);
  const [sortKey, setSortKey] = useState<SortKey>("client_name");
  const [sortDir, setSortDir] = useState<SortDir>("asc");
  const supabase = createClient();

  async function loadOrders() {
    const { data } = await supabase
      .from("orders")
      .select("*, client:clients(*)")
      .not("status", "in", '("中止","失注")')
      .order("updated_at", { ascending: false });
    if (data) setOrders(data as OrderWithClient[]);
    setLoading(false);
  }

  useEffect(() => {
    loadOrders();
  }, []);

  async function updateField(orderId: string, field: string, value: string) {
    await supabase.from("orders").update({ [field]: value }).eq("id", orderId);
    loadOrders();
  }

  function handleSort(key: SortKey) {
    if (sortKey === key) {
      setSortDir(sortDir === "asc" ? "desc" : "asc");
    } else {
      setSortKey(key);
      setSortDir("asc");
    }
  }

  const sorted = useMemo(() => {
    const result = [...orders];
    result.sort((a, b) => {
      let cmp = 0;
      switch (sortKey) {
        case "client_name":
          cmp = (a.client?.name || "").localeCompare(b.client?.name || "", "ja");
          break;
        case "status":
          cmp = statusSortValue(a.status) - statusSortValue(b.status);
          break;
        case "order_amount":
          cmp = (a.order_amount || 0) - (b.order_amount || 0);
          break;
        case "billing_date":
          cmp = (a.billing_date || "9999").localeCompare(b.billing_date || "9999");
          break;
        case "billing_status":
          cmp = billingSortValue(a.billing_status || "") - billingSortValue(b.billing_status || "");
          break;
        case "subsidy_status":
          cmp = subsidySortValue(a.subsidy_status || "") - subsidySortValue(b.subsidy_status || "");
          break;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });
    return result;
  }, [orders, sortKey, sortDir]);

  function SortHeader({ label, sortKeyName }: { label: string; sortKeyName: SortKey }) {
    const active = sortKey === sortKeyName;
    return (
      <th
        className="px-3 py-2 text-left text-xs font-medium text-muted-foreground cursor-pointer select-none hover:text-foreground whitespace-nowrap"
        onClick={() => handleSort(sortKeyName)}
      >
        <span className="inline-flex items-center gap-1">
          {label}
          {active && (
            <span className="text-foreground">{sortDir === "asc" ? "↑" : "↓"}</span>
          )}
        </span>
      </th>
    );
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground text-sm">読み込み中...</p>
      </div>
    );
  }

  const billingUnpaid = orders.filter((o) => o.billing_status === "未請求");
  const billingInvoiced = orders.filter((o) => o.billing_status === "請求済");
  const billingPaid = orders.filter((o) => o.billing_status === "入金済");

  const totalAmount = orders.reduce(
    (sum, o) => sum + (o.order_amount || 0),
    0
  );
  const paidAmount = billingPaid.reduce(
    (sum, o) => sum + (o.order_amount || 0),
    0
  );

  return (
    <div className="space-y-4">
      <h2 className="text-lg font-semibold">請求・助成金管理</h2>

      {/* Summary cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        <Card className="py-0">
          <CardHeader className="px-4 pt-3 pb-1">
            <CardTitle className="text-xs text-muted-foreground font-normal">
              総受注金額
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            <p className="text-2xl font-bold tabular-nums">
              {totalAmount.toLocaleString()}
              <span className="text-xs font-normal text-muted-foreground ml-0.5">円</span>
            </p>
          </CardContent>
        </Card>
        <Card className="py-0">
          <CardHeader className="px-4 pt-3 pb-1">
            <CardTitle className="text-xs text-muted-foreground font-normal">
              入金済
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            <p className="text-2xl font-bold tabular-nums text-green-700">
              {paidAmount.toLocaleString()}
              <span className="text-xs font-normal text-muted-foreground ml-0.5">円</span>
            </p>
          </CardContent>
        </Card>
        <Card className="py-0">
          <CardHeader className="px-4 pt-3 pb-1">
            <CardTitle className="text-xs text-muted-foreground font-normal">
              未請求件数
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            <p className="text-2xl font-bold tabular-nums text-orange-600">
              {billingUnpaid.length}
              <span className="text-xs font-normal text-muted-foreground ml-0.5">件</span>
            </p>
          </CardContent>
        </Card>
        <Card className="py-0">
          <CardHeader className="px-4 pt-3 pb-1">
            <CardTitle className="text-xs text-muted-foreground font-normal">
              請求済(入金待ち)
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            <p className="text-2xl font-bold tabular-nums text-blue-600">
              {billingInvoiced.length}
              <span className="text-xs font-normal text-muted-foreground ml-0.5">件</span>
            </p>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="billing">
        <TabsList>
          <TabsTrigger value="billing" className="text-xs">請求管理</TabsTrigger>
          <TabsTrigger value="subsidy" className="text-xs">助成金管理</TabsTrigger>
        </TabsList>

        <TabsContent value="billing" className="mt-3">
          <div className="border rounded overflow-auto max-h-[calc(100vh-340px)]">
            <table className="w-full text-sm">
              <thead className="bg-muted/50 sticky top-0 z-10">
                <tr>
                  <SortHeader label="クライアント" sortKeyName="client_name" />
                  <SortHeader label="ステータス" sortKeyName="status" />
                  <SortHeader label="受注金額" sortKeyName="order_amount" />
                  <th className="px-3 py-2 text-left text-xs font-medium text-muted-foreground whitespace-nowrap">請求日</th>
                  <SortHeader label="請求ステータス" sortKeyName="billing_status" />
                </tr>
              </thead>
              <tbody className="divide-y">
                {sorted.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="px-3 py-8 text-center text-muted-foreground text-xs">
                      該当する案件がありません
                    </td>
                  </tr>
                ) : (
                  sorted.map((order) => (
                    <tr key={order.id} className="hover:bg-muted/30 transition-colors">
                      <td className="px-3 py-1.5">
                        <Link
                          href={`/orders/${order.id}`}
                          className="text-sm hover:underline"
                        >
                          {order.client?.name}
                        </Link>
                      </td>
                      <td className="px-3 py-1.5">
                        <Badge
                          variant="secondary"
                          className={cn(STATUS_COLORS[order.status] || "", "text-[11px] font-normal")}
                        >
                          {ORDER_STATUS_LABELS[order.status as OrderStatus] || order.status}
                        </Badge>
                      </td>
                      <td className="px-3 py-1.5 text-xs text-right tabular-nums">
                        {order.order_amount
                          ? `${order.order_amount.toLocaleString()}`
                          : "-"}
                      </td>
                      <td className="px-3 py-1.5 text-xs tabular-nums text-muted-foreground">
                        {order.billing_date || "-"}
                      </td>
                      <td className="px-3 py-1.5">
                        <Select
                          value={order.billing_status}
                          onValueChange={(val) => {
                            if (val) updateField(order.id, "billing_status", val);
                          }}
                        >
                          <SelectTrigger className="h-6 w-auto border-0 bg-transparent p-0 text-xs">
                            <span className={cn(
                              "text-[11px]",
                              order.billing_status === "入金済" ? "text-green-700" :
                              order.billing_status === "請求済" ? "text-blue-700" :
                              "text-muted-foreground"
                            )}>
                              {order.billing_status}
                            </span>
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="未請求">未請求</SelectItem>
                            <SelectItem value="請求済">請求済</SelectItem>
                            <SelectItem value="入金済">入金済</SelectItem>
                          </SelectContent>
                        </Select>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </TabsContent>

        <TabsContent value="subsidy" className="mt-3">
          <div className="border rounded overflow-auto max-h-[calc(100vh-340px)]">
            <table className="w-full text-sm">
              <thead className="bg-muted/50 sticky top-0 z-10">
                <tr>
                  <SortHeader label="クライアント" sortKeyName="client_name" />
                  <SortHeader label="ステータス" sortKeyName="status" />
                  <SortHeader label="受注金額" sortKeyName="order_amount" />
                  <SortHeader label="助成金ステータス" sortKeyName="subsidy_status" />
                </tr>
              </thead>
              <tbody className="divide-y">
                {sorted.length === 0 ? (
                  <tr>
                    <td colSpan={4} className="px-3 py-8 text-center text-muted-foreground text-xs">
                      該当する案件がありません
                    </td>
                  </tr>
                ) : (
                  sorted.map((order) => (
                    <tr key={order.id} className="hover:bg-muted/30 transition-colors">
                      <td className="px-3 py-1.5">
                        <Link
                          href={`/orders/${order.id}`}
                          className="text-sm hover:underline"
                        >
                          {order.client?.name}
                        </Link>
                      </td>
                      <td className="px-3 py-1.5">
                        <Badge
                          variant="secondary"
                          className={cn(STATUS_COLORS[order.status] || "", "text-[11px] font-normal")}
                        >
                          {ORDER_STATUS_LABELS[order.status as OrderStatus] || order.status}
                        </Badge>
                      </td>
                      <td className="px-3 py-1.5 text-xs text-right tabular-nums">
                        {order.order_amount
                          ? `${order.order_amount.toLocaleString()}`
                          : "-"}
                      </td>
                      <td className="px-3 py-1.5">
                        <Select
                          value={order.subsidy_status}
                          onValueChange={(val) => {
                            if (val) updateField(order.id, "subsidy_status", val);
                          }}
                        >
                          <SelectTrigger className="h-6 w-auto border-0 bg-transparent p-0 text-xs">
                            <span className={cn(
                              "text-[11px]",
                              order.subsidy_status === "完了" ? "text-green-700" :
                              order.subsidy_status === "未申請" ? "text-muted-foreground" :
                              "text-purple-700"
                            )}>
                              {order.subsidy_status}
                            </span>
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="未申請">未申請</SelectItem>
                            <SelectItem value="計画届提出済">計画届提出済</SelectItem>
                            <SelectItem value="申請提出済">申請提出済</SelectItem>
                            <SelectItem value="支給決定">支給決定</SelectItem>
                            <SelectItem value="完了">完了</SelectItem>
                          </SelectContent>
                        </Select>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
