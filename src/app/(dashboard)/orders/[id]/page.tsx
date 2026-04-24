"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
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
  WORKFLOW_STEPS,
  type OrderStatus,
  type BillingStatus,
  type SubsidyStatus,
} from "@/lib/types";
import type { Order, Client, TrainingProgram, TrainingSession } from "@/lib/types";
import Link from "next/link";

export default function OrderDetailPage() {
  const params = useParams();
  const router = useRouter();
  const [order, setOrder] = useState<Order | null>(null);
  const [client, setClient] = useState<Client | null>(null);
  const [program, setProgram] = useState<TrainingProgram | null>(null);
  const [sessions, setSessions] = useState<TrainingSession[]>([]);
  const [editing, setEditing] = useState(false);
  const [loading, setLoading] = useState(true);
  const [form, setForm] = useState<Record<string, string>>({});
  const supabase = createClient();

  async function loadData() {
    const { data: orderData } = await supabase
      .from("orders")
      .select("*")
      .eq("id", params.id)
      .single();

    if (!orderData) {
      setLoading(false);
      return;
    }
    setOrder(orderData);

    const { data: clientData } = await supabase
      .from("clients")
      .select("*")
      .eq("id", orderData.client_id)
      .single();
    if (clientData) setClient(clientData);

    const { data: programData } = await supabase
      .from("training_programs")
      .select("*")
      .eq("order_id", orderData.id)
      .single();
    if (programData) {
      setProgram(programData);
      const { data: sessionsData } = await supabase
        .from("training_sessions")
        .select("*")
        .eq("training_program_id", programData.id)
        .order("day_number");
      if (sessionsData) setSessions(sessionsData);
    }

    setLoading(false);
  }

  useEffect(() => {
    loadData();
  }, [params.id]);

  function startEditing() {
    if (!order) return;
    setForm({
      status: order.status,
      order_date: order.order_date || "",
      order_amount: order.order_amount?.toString() || "",
      next_action_date: order.next_action_date || "",
      next_action_memo: order.next_action_memo || "",
      num_participants: order.num_participants?.toString() || "",
      training_schedule_text: order.training_schedule_text || "",
      billing_date: order.billing_date || "",
      billing_status: order.billing_status,
      subsidy_status: order.subsidy_status,
      memo: order.memo || "",
      notes: order.notes || "",
    });
    setEditing(true);
  }

  async function handleSave() {
    await supabase
      .from("orders")
      .update({
        status: form.status,
        order_date: form.order_date || null,
        order_amount: form.order_amount ? Number(form.order_amount) : null,
        next_action_date: form.next_action_date || null,
        next_action_memo: form.next_action_memo || null,
        num_participants: form.num_participants
          ? Number(form.num_participants)
          : null,
        training_schedule_text: form.training_schedule_text || null,
        billing_date: form.billing_date || null,
        billing_status: form.billing_status,
        subsidy_status: form.subsidy_status,
        memo: form.memo || null,
        notes: form.notes || null,
      })
      .eq("id", params.id);

    setEditing(false);
    loadData();
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">読み込み中...</p>
      </div>
    );
  }

  if (!order || !client) {
    return <p className="text-muted-foreground">案件が見つかりません</p>;
  }

  const currentStep = parseInt(order.status);
  const isNumericStatus = !isNaN(currentStep);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <Button variant="ghost" size="sm" onClick={() => router.back()} className="mb-2">
            &larr; 戻る
          </Button>
          <h1 className="text-2xl font-bold">
            <Link href={`/clients/${client.id}`} className="hover:underline">
              {client.name}
            </Link>
          </h1>
          <div className="flex items-center gap-2 mt-1">
            <Badge variant="outline">{order.product_type}</Badge>
            <Badge
              variant="secondary"
              className={STATUS_COLORS[order.status] || ""}
            >
              {ORDER_STATUS_LABELS[order.status as OrderStatus] || order.status}
            </Badge>
          </div>
        </div>
        <div className="flex gap-2">
          {editing ? (
            <>
              <Button variant="outline" onClick={() => setEditing(false)}>
                キャンセル
              </Button>
              <Button onClick={handleSave}>保存</Button>
            </>
          ) : (
            <Button onClick={startEditing}>編集</Button>
          )}
        </div>
      </div>

      {/* ワークフロー進捗バー */}
      {isNumericStatus && (
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">ワークフロー進捗</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex gap-1">
              {WORKFLOW_STEPS.map((step) => (
                <div
                  key={step.number}
                  className="flex-1 group relative"
                >
                  <div
                    className={`h-2 rounded-full ${
                      step.number <= currentStep
                        ? "bg-primary"
                        : "bg-muted"
                    }`}
                  />
                  <div className="absolute -top-8 left-1/2 -translate-x-1/2 hidden group-hover:block bg-popover border rounded px-2 py-1 text-xs whitespace-nowrap z-10 shadow-sm">
                    {step.number}. {step.name}
                  </div>
                </div>
              ))}
            </div>
            <div className="flex justify-between mt-1">
              <span className="text-xs text-muted-foreground">1</span>
              <span className="text-xs text-muted-foreground">14</span>
            </div>
            <p className="text-sm mt-2 text-center">
              現在: <span className="font-medium">{ORDER_STATUS_LABELS[order.status as OrderStatus]}</span>
            </p>
          </CardContent>
        </Card>
      )}

      <Tabs defaultValue="info">
        <TabsList>
          <TabsTrigger value="info">案件情報</TabsTrigger>
          <TabsTrigger value="billing">請求・助成金</TabsTrigger>
          <TabsTrigger value="training">研修プログラム</TabsTrigger>
        </TabsList>

        <TabsContent value="info" className="space-y-4 mt-4">
          <Card>
            <CardContent className="pt-6">
              {editing ? (
                <div className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label>ステータス</Label>
                      <Select
                        value={form.status || ""}
                        onValueChange={(val) => {
                          if (val) setForm({ ...form, status: val });
                        }}
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          {Object.entries(ORDER_STATUS_LABELS).map(
                            ([key, label]) => (
                              <SelectItem key={key} value={key}>
                                {label}
                              </SelectItem>
                            )
                          )}
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
                      <Label>受注金額</Label>
                      <Input
                        type="number"
                        value={form.order_amount}
                        onChange={(e) =>
                          setForm({ ...form, order_amount: e.target.value })
                        }
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
                          setForm({
                            ...form,
                            next_action_date: e.target.value,
                          })
                        }
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>ネクストアクション内容</Label>
                      <Input
                        value={form.next_action_memo}
                        onChange={(e) =>
                          setForm({
                            ...form,
                            next_action_memo: e.target.value,
                          })
                        }
                      />
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label>受講日程</Label>
                    <Textarea
                      value={form.training_schedule_text}
                      onChange={(e) =>
                        setForm({
                          ...form,
                          training_schedule_text: e.target.value,
                        })
                      }
                      rows={3}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>メモ</Label>
                    <Textarea
                      value={form.memo}
                      onChange={(e) =>
                        setForm({ ...form, memo: e.target.value })
                      }
                      rows={2}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>備考</Label>
                    <Textarea
                      value={form.notes}
                      onChange={(e) =>
                        setForm({ ...form, notes: e.target.value })
                      }
                      rows={2}
                    />
                  </div>
                </div>
              ) : (
                <div className="grid grid-cols-2 gap-6">
                  <div>
                    <p className="text-sm text-muted-foreground">受注日</p>
                    <p>{order.order_date || "-"}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">受注金額</p>
                    <p>
                      {order.order_amount
                        ? `${order.order_amount.toLocaleString()}円`
                        : "-"}
                    </p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">受講人数</p>
                    <p>{order.num_participants ? `${order.num_participants}名` : "-"}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">
                      ネクストアクション
                    </p>
                    <p>{order.next_action_date || "-"}</p>
                    {order.next_action_memo && (
                      <p className="text-sm text-muted-foreground">
                        {order.next_action_memo}
                      </p>
                    )}
                  </div>
                  <div className="col-span-2">
                    <p className="text-sm text-muted-foreground">受講日程</p>
                    <p className="whitespace-pre-wrap">
                      {order.training_schedule_text || "-"}
                    </p>
                  </div>
                  <div className="col-span-2">
                    <Separator />
                  </div>
                  <div className="col-span-2">
                    <p className="text-sm text-muted-foreground">メモ</p>
                    <p className="whitespace-pre-wrap">{order.memo || "-"}</p>
                  </div>
                  <div className="col-span-2">
                    <p className="text-sm text-muted-foreground">備考</p>
                    <p className="whitespace-pre-wrap">{order.notes || "-"}</p>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="billing" className="space-y-4 mt-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">請求・助成金情報</CardTitle>
            </CardHeader>
            <CardContent>
              {editing ? (
                <div className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label>請求日</Label>
                      <Input
                        type="date"
                        value={form.billing_date}
                        onChange={(e) =>
                          setForm({ ...form, billing_date: e.target.value })
                        }
                      />
                    </div>
                    <div className="space-y-2">
                      <Label>請求ステータス</Label>
                      <Select
                        value={form.billing_status || ""}
                        onValueChange={(val) => {
                          if (val) setForm({ ...form, billing_status: val });
                        }}
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="未請求">未請求</SelectItem>
                          <SelectItem value="請求済">請求済</SelectItem>
                          <SelectItem value="入金済">入金済</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label>助成金ステータス</Label>
                    <Select
                      value={form.subsidy_status || ""}
                      onValueChange={(val) => {
                        if (val) setForm({ ...form, subsidy_status: val });
                      }}
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="未申請">未申請</SelectItem>
                        <SelectItem value="計画届提出済">計画届提出済</SelectItem>
                        <SelectItem value="申請提出済">申請提出済</SelectItem>
                        <SelectItem value="支給決定">支給決定</SelectItem>
                        <SelectItem value="完了">完了</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              ) : (
                <div className="grid grid-cols-2 gap-6">
                  <div>
                    <p className="text-sm text-muted-foreground">請求日</p>
                    <p>{order.billing_date || "-"}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">請求ステータス</p>
                    <Badge
                      variant="outline"
                      className={
                        order.billing_status === "入金済"
                          ? "text-green-600 border-green-300"
                          : order.billing_status === "請求済"
                          ? "text-blue-600 border-blue-300"
                          : ""
                      }
                    >
                      {order.billing_status}
                    </Badge>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">
                      助成金ステータス
                    </p>
                    <Badge
                      variant="outline"
                      className={
                        order.subsidy_status === "完了"
                          ? "text-green-600 border-green-300"
                          : order.subsidy_status === "未申請"
                          ? ""
                          : "text-purple-600 border-purple-300"
                      }
                    >
                      {order.subsidy_status}
                    </Badge>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">受注金額</p>
                    <p className="text-lg font-semibold">
                      {order.order_amount
                        ? `${order.order_amount.toLocaleString()}円`
                        : "-"}
                    </p>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="training" className="space-y-4 mt-4">
          {program ? (
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">研修プログラム</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <p className="text-sm text-muted-foreground">ステータス</p>
                    <Badge variant="outline">{program.status}</Badge>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">時間・日数</p>
                    <p>{program.duration_text || "-"}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">会場</p>
                    <p>{program.venue || "-"} ({program.venue_type})</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">実施人数</p>
                    <p>{program.num_participants ? `${program.num_participants}名` : "-"}</p>
                  </div>
                  <div>
                    <p className="text-sm text-muted-foreground">研修対象</p>
                    <p>{program.training_target || "-"}</p>
                  </div>
                </div>

                {sessions.length > 0 && (
                  <>
                    <Separator />
                    <h3 className="font-medium">研修日程</h3>
                    <div className="space-y-2">
                      {sessions.map((s) => (
                        <div
                          key={s.id}
                          className="flex items-center gap-4 p-3 rounded-lg bg-muted/50"
                        >
                          <Badge variant="outline">
                            第{s.day_number}日目
                          </Badge>
                          <span className="text-sm">
                            {s.session_date || "日程未定"}
                          </span>
                          <span className="text-sm text-muted-foreground">
                            {s.start_time}〜{s.end_time}
                          </span>
                          <span className="text-sm">
                            講師: {s.instructor || "未定"}
                          </span>
                        </div>
                      ))}
                    </div>
                  </>
                )}

                <Separator />
                <div className="space-y-2">
                  {program.meeting_notes_url && (
                    <a
                      href={program.meeting_notes_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block text-sm text-blue-600 hover:underline"
                    >
                      商談議事録/カリキュラム
                    </a>
                  )}
                  {program.pre_survey_url && (
                    <a
                      href={program.pre_survey_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block text-sm text-blue-600 hover:underline"
                    >
                      事前アンケート
                    </a>
                  )}
                  {program.training_materials_url && (
                    <a
                      href={program.training_materials_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block text-sm text-blue-600 hover:underline"
                    >
                      研修資料
                    </a>
                  )}
                  {program.archive_url && (
                    <a
                      href={program.archive_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block text-sm text-blue-600 hover:underline"
                    >
                      研修アーカイブ
                    </a>
                  )}
                  {program.post_survey_url && (
                    <a
                      href={program.post_survey_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block text-sm text-blue-600 hover:underline"
                    >
                      研修後アンケート
                    </a>
                  )}
                </div>
              </CardContent>
            </Card>
          ) : (
            <Card>
              <CardContent className="py-8 text-center">
                <p className="text-muted-foreground mb-4">
                  研修プログラムが未登録です
                </p>
                <Link href={`/training?order_id=${order.id}`}>
                  <Button variant="outline">研修プログラムを作成</Button>
                </Link>
              </CardContent>
            </Card>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
