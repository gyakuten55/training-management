"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { ORDER_STATUS_LABELS, STATUS_COLORS } from "@/lib/types";
import type { Client, Order } from "@/lib/types";
import Link from "next/link";

export default function ClientDetailPage() {
  const params = useParams();
  const router = useRouter();
  const [client, setClient] = useState<Client | null>(null);
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    async function load() {
      const { data: clientData } = await supabase
        .from("clients")
        .select("*")
        .eq("id", params.id)
        .single();
      if (clientData) setClient(clientData);

      const { data: ordersData } = await supabase
        .from("orders")
        .select("*")
        .eq("client_id", params.id)
        .order("created_at", { ascending: false });
      if (ordersData) setOrders(ordersData);

      setLoading(false);
    }
    load();
  }, [params.id, supabase]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">読み込み中...</p>
      </div>
    );
  }

  if (!client) {
    return <p className="text-muted-foreground">クライアントが見つかりません</p>;
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <Button
            variant="ghost"
            size="sm"
            onClick={() => router.back()}
            className="mb-2"
          >
            &larr; 戻る
          </Button>
          <h1 className="text-2xl font-bold">{client.name}</h1>
        </div>
        <Link href={`/orders/new?client_id=${client.id}`}>
          <Button>新規案件を追加</Button>
        </Link>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">基本情報</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div>
              <p className="text-sm text-muted-foreground">業界</p>
              <p>{client.industry || "-"}</p>
            </div>
            <div>
              <p className="text-sm text-muted-foreground">URL</p>
              {client.url ? (
                <a
                  href={client.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:underline"
                >
                  {client.url}
                </a>
              ) : (
                <p>-</p>
              )}
            </div>
            <div>
              <p className="text-sm text-muted-foreground">メモ</p>
              <p className="whitespace-pre-wrap">{client.memo || "-"}</p>
            </div>
            <div>
              <p className="text-sm text-muted-foreground">備考</p>
              <p className="whitespace-pre-wrap">{client.notes || "-"}</p>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-lg">案件一覧 ({orders.length}件)</CardTitle>
          </CardHeader>
          <CardContent>
            {orders.length === 0 ? (
              <p className="text-muted-foreground text-sm">案件はありません</p>
            ) : (
              <div className="space-y-3">
                {orders.map((order) => (
                  <Link
                    key={order.id}
                    href={`/orders/${order.id}`}
                    className="block p-3 rounded-lg hover:bg-muted transition-colors border"
                  >
                    <div className="flex items-center justify-between">
                      <p className="font-medium text-sm">
                        {order.product_type}
                      </p>
                      <Badge
                        variant="secondary"
                        className={STATUS_COLORS[order.status] || ""}
                      >
                        {ORDER_STATUS_LABELS[order.status]}
                      </Badge>
                    </div>
                    {order.order_amount && (
                      <p className="text-sm text-muted-foreground mt-1">
                        受注金額: {order.order_amount.toLocaleString()}円
                      </p>
                    )}
                  </Link>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
