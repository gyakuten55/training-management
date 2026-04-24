"use client";

import { Suspense, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { Client } from "@/lib/types";

export default function NewOrderPage() {
  return (
    <Suspense fallback={<div>読み込み中...</div>}>
      <NewOrderForm />
    </Suspense>
  );
}

function NewOrderForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [clients, setClients] = useState<Client[]>([]);
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState({
    client_id: searchParams.get("client_id") || "",
    product_type: "AIリスキリング",
    status: "1",
    order_date: "",
    order_amount: "",
    next_action_date: "",
    next_action_memo: "",
    num_participants: "",
    training_schedule_text: "",
    memo: "",
    notes: "",
  });
  const supabase = createClient();

  useEffect(() => {
    async function loadClients() {
      const { data } = await supabase
        .from("clients")
        .select("*")
        .order("name");
      if (data) setClients(data);
    }
    loadClients();
  }, [supabase]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);

    const { data, error } = await supabase
      .from("orders")
      .insert({
        client_id: form.client_id,
        product_type: form.product_type,
        status: form.status,
        order_date: form.order_date || null,
        order_amount: form.order_amount ? Number(form.order_amount) : null,
        next_action_date: form.next_action_date || null,
        next_action_memo: form.next_action_memo || null,
        num_participants: form.num_participants
          ? Number(form.num_participants)
          : null,
        training_schedule_text: form.training_schedule_text || null,
        memo: form.memo || null,
        notes: form.notes || null,
      })
      .select()
      .single();

    if (error) {
      alert("登録に失敗しました: " + error.message);
      setLoading(false);
      return;
    }

    router.push(`/orders/${data.id}`);
  }

  return (
    <div className="max-w-2xl space-y-6">
      <div>
        <Button variant="ghost" size="sm" onClick={() => router.back()} className="mb-2">
          &larr; 戻る
        </Button>
        <h1 className="text-2xl font-bold">新規案件登録</h1>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">案件情報</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label>クライアント *</Label>
              <Select
                value={form.client_id}
                onValueChange={(val) => { if (val) setForm({ ...form, client_id: val }); }}
              >
                <SelectTrigger>
                  <SelectValue placeholder="クライアントを選択" />
                </SelectTrigger>
                <SelectContent>
                  {clients.map((c) => (
                    <SelectItem key={c.id} value={c.id}>
                      {c.name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>商材</Label>
                <Select
                  value={form.product_type}
                  onValueChange={(val) => {
                    if (val) setForm({ ...form, product_type: val });
                  }}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="AIリスキリング">AIリスキリング</SelectItem>
                    <SelectItem value="AI開発">AI開発</SelectItem>
                    <SelectItem value="Hero AIVO">Hero AIVO</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>受注日</Label>
                <Input
                  type="date"
                  value={form.order_date}
                  onChange={(e) =>
                    setForm({ ...form, order_date: e.target.value })
                  }
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>受注金額 (円)</Label>
                <Input
                  type="number"
                  value={form.order_amount}
                  onChange={(e) =>
                    setForm({ ...form, order_amount: e.target.value })
                  }
                  placeholder="例: 1400000"
                />
              </div>
              <div className="space-y-2">
                <Label>受講人数</Label>
                <Input
                  type="number"
                  value={form.num_participants}
                  onChange={(e) =>
                    setForm({ ...form, num_participants: e.target.value })
                  }
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>ネクストアクション日</Label>
                <Input
                  type="date"
                  value={form.next_action_date}
                  onChange={(e) =>
                    setForm({ ...form, next_action_date: e.target.value })
                  }
                />
              </div>
              <div className="space-y-2">
                <Label>ネクストアクション内容</Label>
                <Input
                  value={form.next_action_memo}
                  onChange={(e) =>
                    setForm({ ...form, next_action_memo: e.target.value })
                  }
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label>受講日程</Label>
              <Textarea
                value={form.training_schedule_text}
                onChange={(e) =>
                  setForm({ ...form, training_schedule_text: e.target.value })
                }
                rows={3}
                placeholder="日程の概要を入力..."
              />
            </div>

            <div className="space-y-2">
              <Label>メモ</Label>
              <Textarea
                value={form.memo}
                onChange={(e) => setForm({ ...form, memo: e.target.value })}
                rows={2}
              />
            </div>

            <div className="space-y-2">
              <Label>備考</Label>
              <Textarea
                value={form.notes}
                onChange={(e) => setForm({ ...form, notes: e.target.value })}
                rows={2}
              />
            </div>

            <div className="flex justify-end gap-2 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => router.back()}
              >
                キャンセル
              </Button>
              <Button type="submit" disabled={loading || !form.client_id}>
                {loading ? "登録中..." : "登録"}
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
