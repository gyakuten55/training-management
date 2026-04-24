"use client";

import { useEffect, useState } from "react";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
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
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import type { UserProfile, WorkflowStep } from "@/lib/types";

export default function SettingsPage() {
  const [users, setUsers] = useState<UserProfile[]>([]);
  const [steps, setSteps] = useState<WorkflowStep[]>([]);
  const [loading, setLoading] = useState(true);
  const [inviteDialogOpen, setInviteDialogOpen] = useState(false);
  const [inviteForm, setInviteForm] = useState({
    email: "",
    password: "",
    name: "",
    role: "internal",
    company_name: "",
  });
  const supabase = createClient();

  async function loadData() {
    const { data: usersData } = await supabase
      .from("user_profiles")
      .select("*")
      .order("created_at");
    if (usersData) setUsers(usersData);

    const { data: stepsData } = await supabase
      .from("workflow_steps")
      .select("*")
      .order("step_number");
    if (stepsData) setSteps(stepsData);

    setLoading(false);
  }

  useEffect(() => {
    loadData();
  }, []);

  async function updateUserRole(userId: string, role: string) {
    await supabase
      .from("user_profiles")
      .update({ role })
      .eq("id", userId);
    loadData();
  }

  async function updateStepName(stepId: number, name: string) {
    await supabase
      .from("workflow_steps")
      .update({ name })
      .eq("id", stepId);
    loadData();
  }

  async function handleInvite(e: React.FormEvent) {
    e.preventDefault();

    const { data, error } = await supabase.auth.signUp({
      email: inviteForm.email,
      password: inviteForm.password,
      options: {
        data: { name: inviteForm.name },
      },
    });

    if (error) {
      alert("ユーザー作成に失敗しました: " + error.message);
      return;
    }

    if (data.user) {
      await supabase
        .from("user_profiles")
        .update({
          name: inviteForm.name,
          role: inviteForm.role,
          company_name: inviteForm.company_name || null,
        })
        .eq("id", data.user.id);
    }

    setInviteDialogOpen(false);
    setInviteForm({
      email: "",
      password: "",
      name: "",
      role: "internal",
      company_name: "",
    });
    loadData();
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">読み込み中...</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">設定</h1>

      <Tabs defaultValue="users">
        <TabsList>
          <TabsTrigger value="users">ユーザー管理</TabsTrigger>
          <TabsTrigger value="workflow">ワークフロー設定</TabsTrigger>
        </TabsList>

        <TabsContent value="users" className="mt-4 space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => setInviteDialogOpen(true)}>
              ユーザーを追加
            </Button>
          </div>

          <Dialog open={inviteDialogOpen} onOpenChange={setInviteDialogOpen}>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>ユーザー追加</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleInvite} className="space-y-4">
                <div className="space-y-2">
                  <Label>名前</Label>
                  <Input
                    value={inviteForm.name}
                    onChange={(e) =>
                      setInviteForm({ ...inviteForm, name: e.target.value })
                    }
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label>メールアドレス</Label>
                  <Input
                    type="email"
                    value={inviteForm.email}
                    onChange={(e) =>
                      setInviteForm({ ...inviteForm, email: e.target.value })
                    }
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label>パスワード</Label>
                  <Input
                    type="password"
                    value={inviteForm.password}
                    onChange={(e) =>
                      setInviteForm({
                        ...inviteForm,
                        password: e.target.value,
                      })
                    }
                    required
                    minLength={6}
                  />
                </div>
                <div className="space-y-2">
                  <Label>ロール</Label>
                  <Select
                    value={inviteForm.role}
                    onValueChange={(val) => {
                      if (val) setInviteForm({ ...inviteForm, role: val });
                    }}
                  >
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="admin">管理者</SelectItem>
                      <SelectItem value="internal">社内ユーザー</SelectItem>
                      <SelectItem value="external">
                        外部ユーザー（松山さん側）
                      </SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                {inviteForm.role === "external" && (
                  <div className="space-y-2">
                    <Label>会社名</Label>
                    <Input
                      value={inviteForm.company_name}
                      onChange={(e) =>
                        setInviteForm({
                          ...inviteForm,
                          company_name: e.target.value,
                        })
                      }
                      placeholder="例: メタヒーローズ"
                    />
                  </div>
                )}
                <div className="flex justify-end gap-2">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => setInviteDialogOpen(false)}
                  >
                    キャンセル
                  </Button>
                  <Button type="submit">追加</Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>

          <div className="rounded-md border">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>名前</TableHead>
                  <TableHead>メールアドレス</TableHead>
                  <TableHead>ロール</TableHead>
                  <TableHead>会社名</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {users.map((user) => (
                  <TableRow key={user.id}>
                    <TableCell className="font-medium">
                      {user.name || "-"}
                    </TableCell>
                    <TableCell>{user.email}</TableCell>
                    <TableCell>
                      <Select
                        value={user.role}
                        onValueChange={(val) => val && updateUserRole(user.id, val)}
                      >
                        <SelectTrigger className="w-[150px]">
                          <Badge
                            variant="outline"
                            className={
                              user.role === "admin"
                                ? "text-red-600 border-red-300"
                                : user.role === "external"
                                ? "text-blue-600 border-blue-300"
                                : ""
                            }
                          >
                            {user.role === "admin"
                              ? "管理者"
                              : user.role === "external"
                              ? "外部"
                              : "社内"}
                          </Badge>
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="admin">管理者</SelectItem>
                          <SelectItem value="internal">社内</SelectItem>
                          <SelectItem value="external">外部</SelectItem>
                        </SelectContent>
                      </Select>
                    </TableCell>
                    <TableCell>{user.company_name || "-"}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </TabsContent>

        <TabsContent value="workflow" className="mt-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">ワークフローステップ</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {steps.map((step) => (
                  <div
                    key={step.id}
                    className="flex items-center gap-3"
                  >
                    <Badge variant="outline" className="w-8 justify-center">
                      {step.step_number}
                    </Badge>
                    <Input
                      defaultValue={step.name}
                      onBlur={(e) => {
                        if (e.target.value !== step.name) {
                          updateStepName(step.id, e.target.value);
                        }
                      }}
                      className="flex-1"
                    />
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
