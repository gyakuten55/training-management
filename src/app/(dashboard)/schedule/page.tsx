"use client";

import { useEffect, useState, useMemo } from "react";
import { createClient } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface SessionWithDetails {
  id: string;
  day_number: number;
  session_date: string | null;
  start_time: string | null;
  end_time: string | null;
  instructor: string | null;
  notes: string | null;
  training_program: {
    id: string;
    venue: string | null;
    venue_type: string;
    duration_text: string | null;
    order: {
      id: string;
      client: {
        id: string;
        name: string;
      };
    };
  };
}

const INSTRUCTORS = ["松山", "中野", "森内", "宮崎", "柏木", "木之下", "水谷"];

export default function SchedulePage() {
  const [sessions, setSessions] = useState<SessionWithDetails[]>([]);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<"calendar" | "list">("calendar");
  const [instructorFilter, setInstructorFilter] = useState("all");
  const [currentMonth, setCurrentMonth] = useState(() => {
    const now = new Date();
    return new Date(now.getFullYear(), now.getMonth(), 1);
  });
  const supabase = createClient();

  useEffect(() => {
    async function loadSessions() {
      const { data } = await supabase
        .from("training_sessions")
        .select(
          "*, training_program:training_programs(*, order:orders(*, client:clients(*)))"
        )
        .not("session_date", "is", null)
        .order("session_date", { ascending: true });

      if (data) setSessions(data as SessionWithDetails[]);
      setLoading(false);
    }
    loadSessions();
  }, [supabase]);

  const filtered = useMemo(() => {
    return sessions.filter((s) => {
      if (instructorFilter !== "all" && s.instructor !== instructorFilter)
        return false;
      return true;
    });
  }, [sessions, instructorFilter]);

  // カレンダー用データ
  const calendarDays = useMemo(() => {
    const year = currentMonth.getFullYear();
    const month = currentMonth.getMonth();
    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();

    const days: { date: Date; sessions: SessionWithDetails[] }[] = [];

    // 前月のパディング
    for (let i = 0; i < firstDay; i++) {
      const d = new Date(year, month, -firstDay + i + 1);
      days.push({ date: d, sessions: [] });
    }

    // 当月
    for (let i = 1; i <= daysInMonth; i++) {
      const d = new Date(year, month, i);
      const dateStr = d.toISOString().split("T")[0];
      const daySessions = filtered.filter((s) => s.session_date === dateStr);
      days.push({ date: d, sessions: daySessions });
    }

    // 次月のパディング（6行にする）
    const remaining = 42 - days.length;
    for (let i = 1; i <= remaining; i++) {
      const d = new Date(year, month + 1, i);
      days.push({ date: d, sessions: [] });
    }

    return days;
  }, [currentMonth, filtered]);

  function prevMonth() {
    setCurrentMonth(
      new Date(currentMonth.getFullYear(), currentMonth.getMonth() - 1, 1)
    );
  }

  function nextMonth() {
    setCurrentMonth(
      new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 1)
    );
  }

  const today = new Date().toISOString().split("T")[0];

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">読み込み中...</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">研修スケジュール</h1>
        <div className="flex gap-2">
          <Select value={instructorFilter} onValueChange={(val) => val && setInstructorFilter(val)}>
            <SelectTrigger className="w-[140px]">
              <SelectValue placeholder="講師" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">全講師</SelectItem>
              {INSTRUCTORS.map((name) => (
                <SelectItem key={name} value={name}>
                  {name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          <Button
            variant={viewMode === "calendar" ? "default" : "outline"}
            size="sm"
            onClick={() => setViewMode("calendar")}
          >
            カレンダー
          </Button>
          <Button
            variant={viewMode === "list" ? "default" : "outline"}
            size="sm"
            onClick={() => setViewMode("list")}
          >
            リスト
          </Button>
        </div>
      </div>

      {viewMode === "calendar" ? (
        <Card>
          <CardHeader>
            <div className="flex items-center justify-between">
              <Button variant="outline" size="sm" onClick={prevMonth}>
                &larr;
              </Button>
              <CardTitle>
                {currentMonth.getFullYear()}年
                {currentMonth.getMonth() + 1}月
              </CardTitle>
              <Button variant="outline" size="sm" onClick={nextMonth}>
                &rarr;
              </Button>
            </div>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-7 gap-px bg-border">
              {["日", "月", "火", "水", "木", "金", "土"].map((d) => (
                <div
                  key={d}
                  className="bg-muted p-2 text-center text-sm font-medium"
                >
                  {d}
                </div>
              ))}
              {calendarDays.map((day, idx) => {
                const dateStr = day.date.toISOString().split("T")[0];
                const isToday = dateStr === today;
                const isCurrentMonth =
                  day.date.getMonth() === currentMonth.getMonth();
                return (
                  <div
                    key={idx}
                    className={`bg-background p-1 min-h-[80px] ${
                      !isCurrentMonth ? "opacity-30" : ""
                    } ${isToday ? "ring-2 ring-primary ring-inset" : ""}`}
                  >
                    <p className="text-xs text-right px-1">
                      {day.date.getDate()}
                    </p>
                    <div className="space-y-0.5 mt-0.5">
                      {day.sessions.slice(0, 3).map((s) => (
                        <div
                          key={s.id}
                          className="text-[10px] px-1 py-0.5 rounded bg-blue-100 text-blue-800 truncate cursor-pointer"
                          title={`${s.training_program?.order?.client?.name} (${s.instructor})`}
                        >
                          {s.training_program?.order?.client?.name?.substring(0, 6)}
                          {s.instructor && ` / ${s.instructor}`}
                        </div>
                      ))}
                      {day.sessions.length > 3 && (
                        <p className="text-[10px] text-muted-foreground px-1">
                          +{day.sessions.length - 3}件
                        </p>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">
          {filtered.length === 0 ? (
            <Card>
              <CardContent className="py-8 text-center text-muted-foreground">
                研修日程がありません
              </CardContent>
            </Card>
          ) : (
            filtered.map((s) => (
              <Card key={s.id}>
                <CardContent className="py-4">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <Badge variant="outline">
                        第{s.day_number}日目
                      </Badge>
                      <div>
                        <p className="font-medium">
                          {s.training_program?.order?.client?.name}
                        </p>
                        <p className="text-sm text-muted-foreground">
                          {s.session_date} {s.start_time}〜{s.end_time}
                        </p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-sm">講師: {s.instructor || "未定"}</p>
                      <Badge variant="secondary" className="text-xs">
                        {s.training_program?.venue_type}
                      </Badge>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </div>
      )}
    </div>
  );
}
