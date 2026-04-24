"use client";

import { useEffect, useState, useMemo } from "react";
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
import type { Client } from "@/lib/types";
import Link from "next/link";

type SortKey = "name" | "industry" | "created_at";
type SortDir = "asc" | "desc";

export default function ClientsPage() {
  const [clients, setClients] = useState<Client[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingClient, setEditingClient] = useState<Client | null>(null);
  const [sortKey, setSortKey] = useState<SortKey>("created_at");
  const [sortDir, setSortDir] = useState<SortDir>("desc");
  const [form, setForm] = useState({
    name: "",
    url: "",
    industry: "",
    memo: "",
    notes: "",
  });
  const supabase = createClient();

  async function loadClients() {
    const { data } = await supabase
      .from("clients")
      .select("*")
      .order("created_at", { ascending: false });
    if (data) setClients(data);
    setLoading(false);
  }

  useEffect(() => {
    loadClients();
  }, []);

  function openCreateDialog() {
    setEditingClient(null);
    setForm({ name: "", url: "", industry: "", memo: "", notes: "" });
    setDialogOpen(true);
  }

  function openEditDialog(client: Client) {
    setEditingClient(client);
    setForm({
      name: client.name,
      url: client.url || "",
      industry: client.industry || "",
      memo: client.memo || "",
      notes: client.notes || "",
    });
    setDialogOpen(true);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const payload = {
      name: form.name,
      url: form.url || null,
      industry: form.industry || null,
      memo: form.memo || null,
      notes: form.notes || null,
    };

    if (editingClient) {
      await supabase.from("clients").update(payload).eq("id", editingClient.id);
    } else {
      await supabase.from("clients").insert(payload);
    }

    setDialogOpen(false);
    loadClients();
  }

  async function handleDelete(id: string) {
    if (!confirm("このクライアントを削除しますか？関連する案件も削除されます。")) return;
    await supabase.from("clients").delete().eq("id", id);
    loadClients();
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
    let result = clients.filter(
      (c) =>
        !search ||
        c.name.toLowerCase().includes(search.toLowerCase()) ||
        (c.industry && c.industry.toLowerCase().includes(search.toLowerCase()))
    );

    result.sort((a, b) => {
      let cmp = 0;
      switch (sortKey) {
        case "name":
          cmp = a.name.localeCompare(b.name, "ja");
          break;
        case "industry":
          cmp = (a.industry || "").localeCompare(b.industry || "", "ja");
          break;
        case "created_at":
          cmp = (a.created_at || "").localeCompare(b.created_at || "");
          break;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });

    return result;
  }, [clients, search, sortKey, sortDir]);

  function SortHeader({ label, sortKeyName }: { label: string; sortKeyName: SortKey }) {
    const active = sortKey === sortKeyName;
    return (
      <th
        className="px-3 py-2 text-left text-xs font-medium text-muted-foreground cursor-pointer select-none hover:text-foreground whitespace-nowrap"
        onClick={() => handleSort(sortKeyName)}
      >
        <span className="inline-flex items-center gap-1">
          {label}
          {active && <span className="text-foreground">{sortDir === "asc" ? "↑" : "↓"}</span>}
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
        <h2 className="text-lg font-semibold">クライアント</h2>
        <Button size="sm" variant="outline" onClick={openCreateDialog}>新規登録</Button>
      </div>

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle className="text-sm font-medium">
              {editingClient ? "クライアント編集" : "クライアント新規登録"}
            </DialogTitle>
          </DialogHeader>
          <form onSubmit={handleSubmit} className="space-y-3">
            <div className="space-y-1">
              <Label className="text-xs">会社名</Label>
              <Input
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                required
                className="h-8 text-sm"
              />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1">
                <Label className="text-xs">会社URL</Label>
                <Input
                  value={form.url}
                  onChange={(e) => setForm({ ...form, url: e.target.value })}
                  className="h-8 text-sm"
                />
              </div>
              <div className="space-y-1">
                <Label className="text-xs">業界</Label>
                <Input
                  value={form.industry}
                  onChange={(e) => setForm({ ...form, industry: e.target.value })}
                  className="h-8 text-sm"
                />
              </div>
            </div>
            <div className="space-y-1">
              <Label className="text-xs">メモ</Label>
              <Textarea
                value={form.memo}
                onChange={(e) => setForm({ ...form, memo: e.target.value })}
                rows={2}
                className="text-sm"
              />
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <Button type="button" variant="ghost" size="sm" onClick={() => setDialogOpen(false)}>
                キャンセル
              </Button>
              <Button type="submit" size="sm">{editingClient ? "更新" : "登録"}</Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>

      <div className="flex items-center gap-2">
        <Input
          placeholder="検索..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-48 h-8 text-sm"
        />
        <span className="text-xs text-muted-foreground ml-auto">
          {filtered.length} / {clients.length}件
        </span>
      </div>

      <div className="border rounded overflow-auto max-h-[calc(100vh-200px)]">
        <table className="w-full text-sm">
          <thead className="bg-muted/50 sticky top-0 z-10">
            <tr>
              <SortHeader label="会社名" sortKeyName="name" />
              <SortHeader label="業界" sortKeyName="industry" />
              <th className="px-3 py-2 text-left text-xs font-medium text-muted-foreground">URL</th>
              <th className="px-3 py-2 text-left text-xs font-medium text-muted-foreground">メモ</th>
              <th className="px-3 py-2 text-right text-xs font-medium text-muted-foreground w-20">操作</th>
            </tr>
          </thead>
          <tbody className="divide-y">
            {filtered.length === 0 ? (
              <tr>
                <td colSpan={5} className="px-3 py-8 text-center text-muted-foreground text-xs">
                  該当するクライアントがありません
                </td>
              </tr>
            ) : (
              filtered.map((client) => (
                <tr key={client.id} className="hover:bg-muted/30 transition-colors">
                  <td className="px-3 py-1.5">
                    <Link href={`/clients/${client.id}`} className="hover:underline text-sm">
                      {client.name}
                    </Link>
                  </td>
                  <td className="px-3 py-1.5 text-xs text-muted-foreground">
                    {client.industry || "-"}
                  </td>
                  <td className="px-3 py-1.5 text-xs">
                    {client.url ? (
                      <a href={client.url} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">
                        link
                      </a>
                    ) : "-"}
                  </td>
                  <td className="px-3 py-1.5 text-xs text-muted-foreground max-w-[200px] truncate">
                    {client.memo || "-"}
                  </td>
                  <td className="px-3 py-1.5 text-right">
                    <button
                      className="text-xs text-muted-foreground hover:text-foreground mr-2"
                      onClick={() => openEditDialog(client)}
                    >
                      編集
                    </button>
                    <button
                      className="text-xs text-muted-foreground hover:text-destructive"
                      onClick={() => handleDelete(client.id)}
                    >
                      削除
                    </button>
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
