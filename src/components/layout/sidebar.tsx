"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";
import { createClient } from "@/lib/supabase";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import type { UserProfile } from "@/lib/types";

const navItems = [
  { href: "/", label: "ダッシュボード" },
  { href: "/orders", label: "案件管理" },
  { href: "/schedule", label: "研修スケジュール" },
  { href: "/billing", label: "請求・助成金" },
  { href: "/training", label: "発注管理" },
  { href: "/clients", label: "クライアント" },
];

const adminItems = [
  { href: "/settings", label: "設定" },
];

export function Sidebar() {
  const pathname = usePathname();
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const supabase = createClient();

  useEffect(() => {
    async function loadProfile() {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { data } = await supabase
          .from("user_profiles")
          .select("*")
          .eq("id", user.id)
          .single();
        if (data) setProfile(data);
      }
    }
    loadProfile();
  }, [supabase]);

  async function handleLogout() {
    await supabase.auth.signOut();
    window.location.href = "/login";
  }

  const isExternal = profile?.role === "external";
  const filteredItems = isExternal
    ? navItems.filter((item) => item.href === "/training")
    : navItems;

  return (
    <aside className="w-56 bg-card border-r border-border flex flex-col h-full">
      <div className="px-4 py-5 border-b border-border">
        <h1 className="font-semibold text-sm tracking-tight">研修案件管理</h1>
      </div>

      <nav className="flex-1 p-2 space-y-0.5">
        {filteredItems.map((item) => (
          <Link
            key={item.href}
            href={item.href}
            className={cn(
              "block px-3 py-1.5 rounded text-sm transition-colors",
              pathname === item.href
                ? "bg-foreground/10 text-foreground font-medium"
                : "text-muted-foreground hover:text-foreground hover:bg-foreground/5"
            )}
          >
            {item.label}
          </Link>
        ))}

        {profile?.role === "admin" && (
          <>
            <div className="pt-4 pb-1">
              <p className="text-[11px] font-medium text-muted-foreground/60 uppercase tracking-wider px-3">
                管理
              </p>
            </div>
            {adminItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={cn(
                  "block px-3 py-1.5 rounded text-sm transition-colors",
                  pathname === item.href
                    ? "bg-foreground/10 text-foreground font-medium"
                    : "text-muted-foreground hover:text-foreground hover:bg-foreground/5"
                )}
              >
                {item.label}
              </Link>
            ))}
          </>
        )}
      </nav>

      <div className="p-3 border-t border-border">
        {profile && (
          <div className="mb-2 px-1">
            <p className="text-xs font-medium truncate">{profile.name || profile.email}</p>
            <p className="text-[11px] text-muted-foreground">
              {profile.role === "admin"
                ? "管理者"
                : profile.role === "external"
                ? `外部 (${profile.company_name || ""})`
                : "社内"}
            </p>
          </div>
        )}
        <Button
          variant="ghost"
          size="sm"
          className="w-full justify-start text-muted-foreground text-xs h-7"
          onClick={handleLogout}
        >
          ログアウト
        </Button>
      </div>
    </aside>
  );
}
