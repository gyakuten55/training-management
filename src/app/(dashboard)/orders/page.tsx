"use client";

import { useEffect, useState, useMemo } from "react";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  ORDER_STATUS_LABELS,
  STATUS_COLORS,
  type OrderStatus,
} from "@/lib/types";
import type { Order, Client } from "@/lib/types";
import Link from "next/link";
import { cn } from "@/lib/utils";

interface OrderWithClient extends Order {
  client: Client;
}

type SortKey = "client_name" | "status" | "order_amount" | "num_participants" | "next_action_date" | "billing_status" | "subsidy_status" | "updated_at";
type SortDir = "asc" | "desc";

function statusSortValue(s: string): number {
  if (s === "完了") return 100;
  if (s === "中止") return 101;
  if (s === "失注") return 102;
  const n = parseInt(s);
  return isNaN(n) ? 50 : n;
}

export default function OrdersPage() {
  const [orders, setOrders] = useState<OrderWithClient[]>([]);
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("all");
  const [productFilter, setProductFilter] = useState<string>("all");
  const [sortKey, setSortKey] = useState<SortKey>("updated_at");
  const [sortDir, setSortDir] = useState<SortDir>("desc");
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  async function loadOrders() {
    const { data } = await supabase
      .from("orders")
      .select("*, client:clients(*)")
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

  const filtered = useMemo(() => {
    let result = orders.filter((o) => {
      const matchSearch =
        !search ||
        o.client?.name?.toLowerCase().includes(search.toLowerCase()) ||
        o.memo?.toLowerCase().includes(search.toLowerCase()) ||
        o.notes?.toLowerCase().includes(search.toLowerCase());
      const matchStatus =
        statusFilter === "all" ||
        (statusFilter === "active" && !["完了", "中止", "失注"].includes(o.status)) ||
        o.status === statusFilter;
      const matchProduct =
        productFilter === "all" || o.product_type === productFilter;
      return matchSearch && matchStatus && matchProduct;
    });

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
        case "num_participants":
          cmp = (a.num_participants || 0) - (b.num_participants || 0);
          break;
        case "next_action_date":
          cmp = (a.next_action_date || "9999").localeCompare(b.next_action_date || "9999");
          break;
        case "billing_status":
          cmp = (a.billing_status || "").localeCompare(b.billing_status || "", "ja");
          break;
        case "subsidy_status":
          cmp = (a.subsidy_status || "").localeCompare(b.subsidy_status || "", "ja");
          break;
        case "updated_at":
          cmp = (a.updated_at || "").localeCompare(b.updated_at || "");
          break;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });

    return result;
  }, [orders, search, statusFilter, productFilter, sortKey, sortDir]);

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

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-lg font-semibold">案件管理</h2>
        <Link href="/orders/new">
          <Button size="sm" variant="outline">新規登録</Button>
        </Link>
      </div>

      <div className="flex flex-wrap items-center gap-2">
        <Input
          placeholder="検索..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-48 h-8 text-sm"
        />
        <Select value={statusFilter} onValueChange={(val) => val && setStatusFilter(val)}>
          <SelectTrigger className="w-40 h-8 text-xs">
            <SelectValue placeholder="ステータス" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">全ステータス</SelectItem>
            <SelectItem value="active">進行中のみ</SelectItem>
            {Object.entries(ORDER_STATUS_LABELS).map(([key, label]) => (
              <SelectItem key={key} value={key}>{label}</SelectItem>
            ))}
          </SelectContent>
        </Select>
        <Select value={productFilter} onValueChange={(val) => val && setProductFilter(val)}>
          <SelectTrigger className="w-36 h-8 text-xs">
            <SelectValue placeholder="商材" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">全商材</SelectItem>
            <SelectItem value="AIリスキリング">AIリスキリング</SelectItem>
            <SelectItem value="AI開発">AI開発</SelectItem>
            <SelectItem value="Hero AIVO">Hero AIVO</SelectItem>
          </SelectContent>
        </Select>
        <span className="text-xs text-muted-foreground ml-auto">
          {filtered.length} / {orders.length}件
        </span>
      </div>

      <div className="border rounded overflow-auto max-h-[calc(100vh-200px)]">
        <table className="w-full text-sm">
          <thead className="bg-muted/50 sticky top-0 z-10">
            <tr>
              <SortHeader label="クライアント" sortKeyName="client_name" />
              <th className="px-3 py-2 text-left text-xs font-medium text-muted-foreground">商材</th>
              <SortHeader label="ステータス" sortKeyName="status" />
              <SortHeader label="受注金額" sortKeyName="order_amount" />
              <SortHeader label="人数" sortKeyName="num_participants" />
              <SortHeader label="ネクストアクション" sortKeyName="next_action_date" />
              <SortHeader label="請求" sortKeyName="billing_status" />
              <SortHeader label="助成金" sortKeyName="subsidy_status" />
            </tr>
          </thead>
          <tbody className="divide-y">
            {filtered.length === 0 ? (
              <tr>
                <td colSpan={8} className="px-3 py-8 text-center text-muted-foreground text-xs">
                  該当する案件がありません
                </td>
              </tr>
            ) : (
              filtered.map((order) => (
                <tr key={order.id} className="hover:bg-muted/30 transition-colors">
                  <td className="px-3 py-1.5">
                    <Link
                      href={`/orders/${order.id}`}
                      className="text-sm hover:underline"
                    >
                      {order.client?.name}
                    </Link>
                  </td>
                  <td className="px-3 py-1.5 text-xs text-muted-foreground">
                    {order.product_type}
                  </td>
                  <td className="px-3 py-1.5">
                    <Select
                      value={order.status}
                      onValueChange={(val) => val && updateField(order.id, "status", val)}
                    >
                      <SelectTrigger className="h-6 w-auto border-0 bg-transparent p-0 text-xs">
                        <Badge
                          variant="secondary"
                          className={cn(STATUS_COLORS[order.status] || "", "text-[11px] font-normal")}
                        >
                          {ORDER_STATUS_LABELS[order.status as OrderStatus] || order.status}
                        </Badge>
                      </SelectTrigger>
                      <SelectContent>
                        {Object.entries(ORDER_STATUS_LABELS).map(([key, label]) => (
                          <SelectItem key={key} value={key}>{label}</SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </td>
                  <td className="px-3 py-1.5 text-xs text-right tabular-nums">
                    {order.order_amount ? `${order.order_amount.toLocaleString()}` : "-"}
                  </td>
                  <td className="px-3 py-1.5 text-xs text-right tabular-nums">
                    {order.num_participants || "-"}
                  </td>
                  <td className="px-3 py-1.5">
                    <div className="text-xs">
                      <span className="tabular-nums">{order.next_action_date || "-"}</span>
                      {order.next_action_memo && (
                        <span className="block text-[11px] text-muted-foreground truncate max-w-[140px]">
                          {order.next_action_memo}
                        </span>
                      )}
                    </div>
                  </td>
                  <td className="px-3 py-1.5">
                    <Select
                      value={order.billing_status}
                      onValueChange={(val) => val && updateField(order.id, "billing_status", val)}
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
                  <td className="px-3 py-1.5">
                    <Select
                      value={order.subsidy_status}
                      onValueChange={(val) => val && updateField(order.id, "subsidy_status", val)}
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
    </div>
  );
}
