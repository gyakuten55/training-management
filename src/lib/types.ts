export type UserRole = "admin" | "internal" | "external";

export type ProductType = "AIリスキリング" | "AI開発" | "Hero AIVO";

export type OrderStatus =
  | "1"
  | "2"
  | "3"
  | "4"
  | "5"
  | "6"
  | "7"
  | "8"
  | "9"
  | "10"
  | "11"
  | "12"
  | "13"
  | "14"
  | "完了"
  | "中止"
  | "失注";

export type BillingStatus = "未請求" | "請求済" | "入金済";

export type SubsidyStatus =
  | "未申請"
  | "計画届提出済"
  | "申請提出済"
  | "支給決定"
  | "完了";

export type TrainingProgramStatus = "受注済" | "研修中" | "研修完了";

export type VenueType = "オンライン" | "対面" | "ハイブリッド";

export interface UserProfile {
  id: string;
  email: string;
  name: string;
  role: UserRole;
  company_name: string | null;
  created_at: string;
  updated_at: string;
}

export interface Client {
  id: string;
  name: string;
  url: string | null;
  industry: string | null;
  memo: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface Order {
  id: string;
  client_id: string;
  product_type: ProductType;
  status: OrderStatus;
  order_date: string | null;
  order_amount: number | null;
  next_action_date: string | null;
  next_action_memo: string | null;
  num_participants: number | null;
  training_schedule_text: string | null;
  billing_date: string | null;
  billing_status: BillingStatus;
  subsidy_status: SubsidyStatus;
  memo: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
  // Joined fields
  client?: Client;
  training_program?: TrainingProgram;
}

export interface TrainingProgram {
  id: string;
  order_id: string;
  meeting_notes_url: string | null;
  pre_survey_url: string | null;
  status: TrainingProgramStatus;
  training_target: string | null;
  training_materials_url: string | null;
  duration_text: string | null;
  venue: string | null;
  venue_type: VenueType;
  num_participants: number | null;
  pre_meeting_person: string | null;
  pre_meeting_date: string | null;
  archive_url: string | null;
  post_survey_url: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
  // Joined fields
  order?: Order;
  training_sessions?: TrainingSession[];
}

export interface TrainingSession {
  id: string;
  training_program_id: string;
  day_number: number;
  session_date: string | null;
  start_time: string | null;
  end_time: string | null;
  instructor: string | null;
  notes: string | null;
}

export interface WorkflowStep {
  id: number;
  step_number: number;
  name: string;
  description: string | null;
}

export const WORKFLOW_STEPS: { number: number; name: string }[] = [
  { number: 1, name: "受講者数の確定" },
  { number: 2, name: "見積・契約" },
  { number: 3, name: "助成金計画届の準備" },
  { number: 4, name: "キックオフ会議・受講日の打診・アンケート打診・ヒアリング日の打診" },
  { number: 5, name: "受講日の確定・カリキュラムの調整" },
  { number: 6, name: "助成金計画届の提出" },
  { number: 7, name: "助成金申請提出" },
  { number: 8, name: "研修準備" },
  { number: 9, name: "研修開始前確認" },
  { number: 10, name: "研修の実施" },
  { number: 11, name: "研修完了・修了証発行" },
  { number: 12, name: "助成金支給申請説明" },
  { number: 13, name: "助成金支給申請に必要な書類の準備" },
  { number: 14, name: "助成金支給申請の提出" },
];

export const ORDER_STATUS_LABELS: Record<OrderStatus, string> = {
  "1": "1. 受講者数の確定",
  "2": "2. 見積・契約",
  "3": "3. 助成金計画届の準備",
  "4": "4. キックオフ会議・日程打診",
  "5": "5. 受講日確定・カリキュラム調整",
  "6": "6. 助成金計画届の提出",
  "7": "7. 助成金申請提出",
  "8": "8. 研修準備",
  "9": "9. 研修開始前確認",
  "10": "10. 研修の実施",
  "11": "11. 研修完了・修了証発行",
  "12": "12. 助成金支給申請説明",
  "13": "13. 書類の準備",
  "14": "14. 助成金支給申請の提出",
  完了: "完了",
  中止: "中止",
  失注: "失注",
};

export const STATUS_COLORS: Record<string, string> = {
  "1": "bg-blue-100 text-blue-800",
  "2": "bg-blue-100 text-blue-800",
  "3": "bg-blue-100 text-blue-800",
  "4": "bg-indigo-100 text-indigo-800",
  "5": "bg-indigo-100 text-indigo-800",
  "6": "bg-purple-100 text-purple-800",
  "7": "bg-purple-100 text-purple-800",
  "8": "bg-yellow-100 text-yellow-800",
  "9": "bg-yellow-100 text-yellow-800",
  "10": "bg-orange-100 text-orange-800",
  "11": "bg-orange-100 text-orange-800",
  "12": "bg-pink-100 text-pink-800",
  "13": "bg-pink-100 text-pink-800",
  "14": "bg-pink-100 text-pink-800",
  完了: "bg-green-100 text-green-800",
  中止: "bg-gray-100 text-gray-800",
  失注: "bg-red-100 text-red-800",
};
