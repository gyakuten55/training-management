"use client";

import { Fragment, Suspense, useEffect, useState, useMemo } from "react";
import { useSearchParams } from "next/navigation";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { cn } from "@/lib/utils";
import type { TrainingProgram, TrainingSession, Order, Client } from "@/lib/types";

interface ProgramWithDetails extends TrainingProgram {
  order: Order & { client: Client };
  training_sessions: TrainingSession[];
}

const INSTRUCTORS = ["松山", "中野", "森内", "宮崎", "柏木", "木之下", "水谷"];

type SortKey = "client_name" | "status" | "duration" | "venue_type" | "participants" | "sessions";
type SortDir = "asc" | "desc";

function statusOrder(s: string): number {
  switch (s) {
    case "研修中": return 0;
    case "受注済": return 1;
    case "研修完了": return 2;
    default: return 3;
  }
}

export default function TrainingPage() {
  return (
    <Suspense fallback={<div>読み込み中...</div>}>
      <TrainingPageContent />
    </Suspense>
  );
}

function TrainingPageContent() {
  const searchParams = useSearchParams();
  const [programs, setPrograms] = useState<ProgramWithDetails[]>([]);
  const [orders, setOrders] = useState<(Order & { client: Client })[]>([]);
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingProgram, setEditingProgram] = useState<ProgramWithDetails | null>(null);
  const [sessionDialogOpen, setSessionDialogOpen] = useState(false);
  const [editingSession, setEditingSession] = useState<{
    programId: string;
    session: TrainingSession | null;
  } | null>(null);

  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("all");
  const [sortKey, setSortKey] = useState<SortKey>("client_name");
  const [sortDir, setSortDir] = useState<SortDir>("asc");
  const [expandedIds, setExpandedIds] = useState<Set<string>>(new Set());

  const [form, setForm] = useState({
    order_id: searchParams.get("order_id") || "",
    status: "受注済",
    training_target: "",
    duration_text: "12時間（5日間）",
    venue: "",
    venue_type: "オンライン",
    num_participants: "",
    pre_meeting_person: "",
    pre_meeting_date: "",
    meeting_notes_url: "",
    pre_survey_url: "",
    training_materials_url: "",
    archive_url: "",
    post_survey_url: "",
    notes: "",
  });

  const [sessionForm, setSessionForm] = useState({
    day_number: "1",
    session_date: "",
    start_time: "",
    end_time: "",
    instructor: "",
    notes: "",
  });

  const supabase = createClient();

  async function loadData() {
    const { data: programsData } = await supabase
      .from("training_programs")
      .select("*, order:orders(*, client:clients(*)), training_sessions(*)")
      .order("created_at", { ascending: false });

    if (programsData) setPrograms(programsData as ProgramWithDetails[]);

    const { data: ordersData } = await supabase
      .from("orders")
      .select("*, client:clients(*)")
      .order("created_at", { ascending: false });
    if (ordersData) setOrders(ordersData as (Order & { client: Client })[]);

    setLoading(false);
  }

  useEffect(() => {
    loadData();
  }, []);

  // --- Sort ---
  function handleSort(key: SortKey) {
    if (sortKey === key) {
      setSortDir(sortDir === "asc" ? "desc" : "asc");
    } else {
      setSortKey(key);
      setSortDir("asc");
    }
  }

  // --- Expand/collapse ---
  function toggleExpand(id: string) {
    setExpandedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  // --- Program dialog ---
  function openCreateDialog() {
    setEditingProgram(null);
    setForm({
      order_id: searchParams.get("order_id") || "",
      status: "受注済",
      training_target: "",
      duration_text: "12時間（5日間）",
      venue: "",
      venue_type: "オンライン",
      num_participants: "",
      pre_meeting_person: "",
      pre_meeting_date: "",
      meeting_notes_url: "",
      pre_survey_url: "",
      training_materials_url: "",
      archive_url: "",
      post_survey_url: "",
      notes: "",
    });
    setDialogOpen(true);
  }

  function openEditDialog(program: ProgramWithDetails) {
    setEditingProgram(program);
    setForm({
      order_id: program.order_id,
      status: program.status,
      training_target: program.training_target || "",
      duration_text: program.duration_text || "",
      venue: program.venue || "",
      venue_type: program.venue_type,
      num_participants: program.num_participants?.toString() || "",
      pre_meeting_person: program.pre_meeting_person || "",
      pre_meeting_date: program.pre_meeting_date || "",
      meeting_notes_url: program.meeting_notes_url || "",
      pre_survey_url: program.pre_survey_url || "",
      training_materials_url: program.training_materials_url || "",
      archive_url: program.archive_url || "",
      post_survey_url: program.post_survey_url || "",
      notes: program.notes || "",
    });
    setDialogOpen(true);
  }

  async function handleProgramSubmit(e: React.FormEvent) {
    e.preventDefault();
    const payload = {
      order_id: form.order_id,
      status: form.status,
      training_target: form.training_target || null,
      duration_text: form.duration_text || null,
      venue: form.venue || null,
      venue_type: form.venue_type,
      num_participants: form.num_participants
        ? Number(form.num_participants)
        : null,
      pre_meeting_person: form.pre_meeting_person || null,
      pre_meeting_date: form.pre_meeting_date || null,
      meeting_notes_url: form.meeting_notes_url || null,
      pre_survey_url: form.pre_survey_url || null,
      training_materials_url: form.training_materials_url || null,
      archive_url: form.archive_url || null,
      post_survey_url: form.post_survey_url || null,
      notes: form.notes || null,
    };

    if (editingProgram) {
      await supabase
        .from("training_programs")
        .update(payload)
        .eq("id", editingProgram.id);
    } else {
      await supabase.from("training_programs").insert(payload);
    }

    setDialogOpen(false);
    loadData();
  }

  // --- Session dialog ---
  function openSessionDialog(programId: string, session?: TrainingSession) {
    setEditingSession({ programId, session: session || null });
    if (session) {
      setSessionForm({
        day_number: session.day_number.toString(),
        session_date: session.session_date || "",
        start_time: session.start_time || "",
        end_time: session.end_time || "",
        instructor: session.instructor || "",
        notes: session.notes || "",
      });
    } else {
      const program = programs.find((p) => p.id === programId);
      const maxDay = program?.training_sessions?.length
        ? Math.max(...program.training_sessions.map((s) => s.day_number))
        : 0;
      setSessionForm({
        day_number: (maxDay + 1).toString(),
        session_date: "",
        start_time: "",
        end_time: "",
        instructor: "",
        notes: "",
      });
    }
    setSessionDialogOpen(true);
  }

  async function handleSessionSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!editingSession) return;

    const payload = {
      training_program_id: editingSession.programId,
      day_number: Number(sessionForm.day_number),
      session_date: sessionForm.session_date || null,
      start_time: sessionForm.start_time || null,
      end_time: sessionForm.end_time || null,
      instructor: sessionForm.instructor || null,
      notes: sessionForm.notes || null,
    };

    if (editingSession.session) {
      await supabase
        .from("training_sessions")
        .update(payload)
        .eq("id", editingSession.session.id);
    } else {
      await supabase.from("training_sessions").insert(payload);
    }

    setSessionDialogOpen(false);
    loadData();
  }

  async function deleteSession(sessionId: string) {
    if (!confirm("この研修日程を削除しますか?")) return;
    await supabase.from("training_sessions").delete().eq("id", sessionId);
    loadData();
  }

  // --- Filter + sort ---
  const filtered = useMemo(() => {
    let result = programs.filter((p) => {
      const matchSearch =
        !search || p.order?.client?.name?.toLowerCase().includes(search.toLowerCase());
      const matchStatus =
        statusFilter === "all" || p.status === statusFilter;
      return matchSearch && matchStatus;
    });

    result.sort((a, b) => {
      let cmp = 0;
      switch (sortKey) {
        case "client_name":
          cmp = (a.order?.client?.name || "").localeCompare(b.order?.client?.name || "", "ja");
          break;
        case "status":
          cmp = statusOrder(a.status) - statusOrder(b.status);
          break;
        case "duration":
          cmp = (a.duration_text || "").localeCompare(b.duration_text || "", "ja");
          break;
        case "venue_type":
          cmp = (a.venue_type || "").localeCompare(b.venue_type || "", "ja");
          break;
        case "participants":
          cmp = (a.num_participants || 0) - (b.num_participants || 0);
          break;
        case "sessions":
          cmp = (a.training_sessions?.length || 0) - (b.training_sessions?.length || 0);
          break;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });

    return result;
  }, [programs, search, statusFilter, sortKey, sortDir]);

  // --- SortHeader ---
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

  // --- Status badge style ---
  function statusStyle(s: string) {
    switch (s) {
      case "研修中":
        return "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200";
      case "受注済":
        return "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200";
      case "研修完了":
        return "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200";
      default:
        return "bg-gray-100 text-gray-800";
    }
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
      {/* Header */}
      <div className="flex items-center justify-between">
        <h2 className="text-lg font-semibold">発注管理（研修プログラム）</h2>
        <Button size="sm" variant="outline" onClick={openCreateDialog}>
          新規登録
        </Button>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap items-center gap-2">
        <Input
          placeholder="クライアント名で検索..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-48 h-8 text-sm"
        />
        <Select value={statusFilter} onValueChange={(val) => val && setStatusFilter(val)}>
          <SelectTrigger className="w-36 h-8 text-xs">
            <SelectValue placeholder="ステータス" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">全ステータス</SelectItem>
            <SelectItem value="受注済">受注済</SelectItem>
            <SelectItem value="研修中">研修中</SelectItem>
            <SelectItem value="研修完了">研修完了</SelectItem>
          </SelectContent>
        </Select>
        <span className="text-xs text-muted-foreground ml-auto">
          {filtered.length} / {programs.length}件
        </span>
      </div>

      {/* Main table */}
      <div className="border rounded overflow-auto max-h-[calc(100vh-200px)]">
        <table className="w-full text-sm">
          <thead className="bg-muted/50 sticky top-0 z-10">
            <tr>
              <th className="px-3 py-2 w-6" />
              <SortHeader label="クライアント" sortKeyName="client_name" />
              <SortHeader label="ステータス" sortKeyName="status" />
              <SortHeader label="時間/日数" sortKeyName="duration" />
              <SortHeader label="形式" sortKeyName="venue_type" />
              <SortHeader label="人数" sortKeyName="participants" />
              <SortHeader label="日程数" sortKeyName="sessions" />
              <th className="px-3 py-2 text-left text-xs font-medium text-muted-foreground">対象</th>
              <th className="px-3 py-2 w-16" />
            </tr>
          </thead>
          <tbody className="divide-y">
            {filtered.length === 0 ? (
              <tr>
                <td colSpan={9} className="px-3 py-8 text-center text-muted-foreground text-xs">
                  研修プログラムがありません
                </td>
              </tr>
            ) : (
              filtered.map((program) => {
                const isExpanded = expandedIds.has(program.id);
                const sessions = (program.training_sessions || []).sort(
                  (a, b) => a.day_number - b.day_number
                );
                const hasLinks =
                  program.meeting_notes_url ||
                  program.pre_survey_url ||
                  program.training_materials_url ||
                  program.archive_url ||
                  program.post_survey_url;

                return (
                  <Fragment key={program.id}>
                    {/* Summary row */}
                    <tr
                      className={cn(
                        "hover:bg-muted/30 cursor-pointer transition-colors",
                        isExpanded && "bg-muted/20"
                      )}
                      onClick={() => toggleExpand(program.id)}
                    >
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {isExpanded ? "▼" : "▶"}
                      </td>
                      <td className="px-3 py-1.5 text-sm">
                        {program.order?.client?.name || "-"}
                      </td>
                      <td className="px-3 py-1.5">
                        <span
                          className={cn(
                            "inline-block px-1.5 py-0.5 rounded text-[11px] font-medium",
                            statusStyle(program.status)
                          )}
                        >
                          {program.status}
                        </span>
                      </td>
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {program.duration_text || "-"}
                      </td>
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {program.venue_type}
                      </td>
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {program.num_participants ? `${program.num_participants}名` : "-"}
                      </td>
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {sessions.length}回
                      </td>
                      <td className="px-3 py-1.5 text-xs text-muted-foreground">
                        {program.training_target || "-"}
                      </td>
                      <td className="px-3 py-1.5 text-right">
                        <button
                          type="button"
                          className="text-xs text-muted-foreground hover:text-foreground px-1.5 py-0.5 rounded hover:bg-muted"
                          onClick={(e) => {
                            e.stopPropagation();
                            openEditDialog(program);
                          }}
                        >
                          編集
                        </button>
                      </td>
                    </tr>

                    {/* Expanded detail */}
                    {isExpanded && (
                      <tr>
                        <td colSpan={9} className="bg-muted/10 px-6 py-3">
                          <div className="space-y-3">
                            {/* Meta info row */}
                            <div className="flex flex-wrap gap-x-6 gap-y-1 text-xs text-muted-foreground">
                              {program.venue && (
                                <span>会場: {program.venue}</span>
                              )}
                              {program.pre_meeting_person && (
                                <span>
                                  事前MTG: {program.pre_meeting_person}
                                  {program.pre_meeting_date && ` (${program.pre_meeting_date})`}
                                </span>
                              )}
                              {program.notes && (
                                <span>備考: {program.notes}</span>
                              )}
                            </div>

                            {/* Links */}
                            {hasLinks && (
                              <div className="flex flex-wrap gap-2">
                                {program.meeting_notes_url && (
                                  <a
                                    href={program.meeting_notes_url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                  >
                                    議事録/カリキュラム
                                  </a>
                                )}
                                {program.pre_survey_url && (
                                  <a
                                    href={program.pre_survey_url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                  >
                                    事前アンケート
                                  </a>
                                )}
                                {program.training_materials_url && (
                                  <a
                                    href={program.training_materials_url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                  >
                                    研修資料
                                  </a>
                                )}
                                {program.archive_url && (
                                  <a
                                    href={program.archive_url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                  >
                                    アーカイブ
                                  </a>
                                )}
                                {program.post_survey_url && (
                                  <a
                                    href={program.post_survey_url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                  >
                                    研修後アンケート
                                  </a>
                                )}
                              </div>
                            )}

                            {/* Sessions sub-table */}
                            <div className="flex items-center justify-between">
                              <span className="text-xs font-medium">研修日程</span>
                              <button
                                type="button"
                                className="text-xs text-blue-600 hover:underline dark:text-blue-400"
                                onClick={() => openSessionDialog(program.id)}
                              >
                                + 日程追加
                              </button>
                            </div>

                            {sessions.length > 0 ? (
                              <table className="w-full text-xs border rounded">
                                <thead className="bg-muted/40">
                                  <tr>
                                    <th className="px-2 py-1 text-left font-medium text-muted-foreground w-16">日目</th>
                                    <th className="px-2 py-1 text-left font-medium text-muted-foreground">日付</th>
                                    <th className="px-2 py-1 text-left font-medium text-muted-foreground">時間</th>
                                    <th className="px-2 py-1 text-left font-medium text-muted-foreground">講師</th>
                                    <th className="px-2 py-1 text-left font-medium text-muted-foreground">備考</th>
                                    <th className="px-2 py-1 w-20" />
                                  </tr>
                                </thead>
                                <tbody className="divide-y">
                                  {sessions.map((session) => (
                                    <tr key={session.id} className="hover:bg-muted/20">
                                      <td className="px-2 py-1">第{session.day_number}日</td>
                                      <td className="px-2 py-1">{session.session_date || "未定"}</td>
                                      <td className="px-2 py-1">
                                        {session.start_time && session.end_time
                                          ? `${session.start_time}-${session.end_time}`
                                          : "-"}
                                      </td>
                                      <td className="px-2 py-1">{session.instructor || "未定"}</td>
                                      <td className="px-2 py-1 text-muted-foreground">
                                        {session.notes || "-"}
                                      </td>
                                      <td className="px-2 py-1 text-right">
                                        <button
                                          type="button"
                                          className="text-muted-foreground hover:text-foreground mr-2"
                                          onClick={() => openSessionDialog(program.id, session)}
                                        >
                                          編集
                                        </button>
                                        <button
                                          type="button"
                                          className="text-destructive hover:underline"
                                          onClick={() => deleteSession(session.id)}
                                        >
                                          削除
                                        </button>
                                      </td>
                                    </tr>
                                  ))}
                                </tbody>
                              </table>
                            ) : (
                              <p className="text-xs text-muted-foreground">日程が登録されていません</p>
                            )}
                          </div>
                        </td>
                      </tr>
                    )}
                  </Fragment>
                );
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Program create/edit dialog */}
      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-sm">
              {editingProgram ? "研修プログラム編集" : "研修プログラム新規登録"}
            </DialogTitle>
          </DialogHeader>
          <form onSubmit={handleProgramSubmit} className="space-y-3">
            <div className="space-y-1">
              <Label className="text-xs">案件 *</Label>
              <Select
                value={form.order_id}
                onValueChange={(val) => { if (val) setForm({ ...form, order_id: val }); }}
              >
                <SelectTrigger className="h-8 text-sm">
                  <SelectValue placeholder="案件を選択" />
                </SelectTrigger>
                <SelectContent>
                  {orders.map((o) => (
                    <SelectItem key={o.id} value={o.id}>
                      {o.client?.name} - {o.product_type}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">ステータス</Label>
                <Select
                  value={form.status}
                  onValueChange={(val) => { if (val) setForm({ ...form, status: val }); }}
                >
                  <SelectTrigger className="h-8 text-sm">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="受注済">受注済</SelectItem>
                    <SelectItem value="研修中">研修中</SelectItem>
                    <SelectItem value="研修完了">研修完了</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-1">
                <Label className="text-xs">研修対象</Label>
                <Input
                  className="h-8 text-sm"
                  value={form.training_target}
                  onChange={(e) => setForm({ ...form, training_target: e.target.value })}
                  placeholder="例: 全員、マネージャー層"
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">時間/日数</Label>
                <Input
                  className="h-8 text-sm"
                  value={form.duration_text}
                  onChange={(e) => setForm({ ...form, duration_text: e.target.value })}
                  placeholder="例: 12時間（5日間）"
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">実施人数</Label>
                <Input
                  className="h-8 text-sm"
                  type="number"
                  value={form.num_participants}
                  onChange={(e) => setForm({ ...form, num_participants: e.target.value })}
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">会場</Label>
                <Input
                  className="h-8 text-sm"
                  value={form.venue}
                  onChange={(e) => setForm({ ...form, venue: e.target.value })}
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">形式</Label>
                <Select
                  value={form.venue_type}
                  onValueChange={(val) => { if (val) setForm({ ...form, venue_type: val }); }}
                >
                  <SelectTrigger className="h-8 text-sm">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="オンライン">オンライン</SelectItem>
                    <SelectItem value="対面">対面</SelectItem>
                    <SelectItem value="ハイブリッド">ハイブリッド</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <hr className="border-border" />

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">事前MTG担当</Label>
                <Input
                  className="h-8 text-sm"
                  value={form.pre_meeting_person}
                  onChange={(e) => setForm({ ...form, pre_meeting_person: e.target.value })}
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">事前MTG日</Label>
                <Input
                  className="h-8 text-sm"
                  type="date"
                  value={form.pre_meeting_date}
                  onChange={(e) => setForm({ ...form, pre_meeting_date: e.target.value })}
                />
              </div>
            </div>

            <div className="space-y-1">
              <Label className="text-xs">商談議事録/カリキュラム URL</Label>
              <Input
                className="h-8 text-sm"
                value={form.meeting_notes_url}
                onChange={(e) => setForm({ ...form, meeting_notes_url: e.target.value })}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-xs">事前アンケート URL</Label>
              <Input
                className="h-8 text-sm"
                value={form.pre_survey_url}
                onChange={(e) => setForm({ ...form, pre_survey_url: e.target.value })}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-xs">研修資料 URL</Label>
              <Input
                className="h-8 text-sm"
                value={form.training_materials_url}
                onChange={(e) => setForm({ ...form, training_materials_url: e.target.value })}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-xs">研修アーカイブ URL</Label>
              <Input
                className="h-8 text-sm"
                value={form.archive_url}
                onChange={(e) => setForm({ ...form, archive_url: e.target.value })}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-xs">研修後アンケート URL</Label>
              <Input
                className="h-8 text-sm"
                value={form.post_survey_url}
                onChange={(e) => setForm({ ...form, post_survey_url: e.target.value })}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-xs">備考</Label>
              <Textarea
                className="text-sm"
                value={form.notes}
                onChange={(e) => setForm({ ...form, notes: e.target.value })}
                rows={2}
              />
            </div>

            <div className="flex justify-end gap-2">
              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={() => setDialogOpen(false)}
              >
                キャンセル
              </Button>
              <Button type="submit" size="sm">
                {editingProgram ? "更新" : "登録"}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      {/* Session create/edit dialog */}
      <Dialog open={sessionDialogOpen} onOpenChange={setSessionDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle className="text-sm">
              {editingSession?.session ? "研修日程編集" : "研修日程追加"}
            </DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSessionSubmit} className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">日目</Label>
                <Input
                  className="h-8 text-sm"
                  type="number"
                  value={sessionForm.day_number}
                  onChange={(e) =>
                    setSessionForm({ ...sessionForm, day_number: e.target.value })
                  }
                  min={1}
                  max={10}
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">日付</Label>
                <Input
                  className="h-8 text-sm"
                  type="date"
                  value={sessionForm.session_date}
                  onChange={(e) =>
                    setSessionForm({ ...sessionForm, session_date: e.target.value })
                  }
                />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">開始時間</Label>
                <Input
                  className="h-8 text-sm"
                  type="time"
                  value={sessionForm.start_time}
                  onChange={(e) =>
                    setSessionForm({ ...sessionForm, start_time: e.target.value })
                  }
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">終了時間</Label>
                <Input
                  className="h-8 text-sm"
                  type="time"
                  value={sessionForm.end_time}
                  onChange={(e) =>
                    setSessionForm({ ...sessionForm, end_time: e.target.value })
                  }
                />
              </div>
            </div>
            <div className="space-y-1">
              <Label className="text-xs">講師</Label>
              <Select
                value={sessionForm.instructor}
                onValueChange={(val) => {
                  if (val) setSessionForm({ ...sessionForm, instructor: val });
                }}
              >
                <SelectTrigger className="h-8 text-sm">
                  <SelectValue placeholder="講師を選択" />
                </SelectTrigger>
                <SelectContent>
                  {INSTRUCTORS.map((name) => (
                    <SelectItem key={name} value={name}>
                      {name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-1">
              <Label className="text-xs">備考</Label>
              <Input
                className="h-8 text-sm"
                value={sessionForm.notes}
                onChange={(e) =>
                  setSessionForm({ ...sessionForm, notes: e.target.value })
                }
              />
            </div>
            <div className="flex justify-end gap-2">
              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={() => setSessionDialogOpen(false)}
              >
                キャンセル
              </Button>
              <Button type="submit" size="sm">
                {editingSession?.session ? "更新" : "追加"}
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
