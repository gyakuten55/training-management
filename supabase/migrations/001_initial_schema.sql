-- ============================================
-- AIリスキリング研修 案件管理システム DB Schema
-- ============================================

-- ユーザープロフィール (Supabase Auth連携)
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  name TEXT NOT NULL DEFAULT '',
  role TEXT NOT NULL DEFAULT 'internal' CHECK (role IN ('admin', 'internal', 'external')),
  company_name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- クライアント企業
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  url TEXT,
  industry TEXT,
  memo TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 受注案件
CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  product_type TEXT NOT NULL DEFAULT 'AIリスキリング' CHECK (product_type IN ('AIリスキリング', 'AI開発', 'Hero AIVO')),
  status TEXT NOT NULL DEFAULT '1',
  order_date DATE,
  order_amount NUMERIC(12, 0),
  next_action_date DATE,
  next_action_memo TEXT,
  num_participants INTEGER,
  training_schedule_text TEXT,
  billing_date DATE,
  billing_status TEXT NOT NULL DEFAULT '未請求' CHECK (billing_status IN ('未請求', '請求済', '入金済')),
  subsidy_status TEXT NOT NULL DEFAULT '未申請' CHECK (subsidy_status IN ('未申請', '計画届提出済', '申請提出済', '支給決定', '完了')),
  memo TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 研修プログラム (発注管理)
CREATE TABLE training_programs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  meeting_notes_url TEXT,
  pre_survey_url TEXT,
  status TEXT NOT NULL DEFAULT '受注済' CHECK (status IN ('受注済', '研修中', '研修完了')),
  training_target TEXT,
  training_materials_url TEXT,
  duration_text TEXT,
  venue TEXT,
  venue_type TEXT NOT NULL DEFAULT 'オンライン' CHECK (venue_type IN ('オンライン', '対面', 'ハイブリッド')),
  num_participants INTEGER,
  pre_meeting_person TEXT,
  pre_meeting_date DATE,
  archive_url TEXT,
  post_survey_url TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 研修日程 (各日)
CREATE TABLE training_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  training_program_id UUID NOT NULL REFERENCES training_programs(id) ON DELETE CASCADE,
  day_number INTEGER NOT NULL CHECK (day_number >= 1 AND day_number <= 10),
  session_date DATE,
  start_time TIME,
  end_time TIME,
  instructor TEXT,
  notes TEXT
);

-- ワークフローステップ定義
CREATE TABLE workflow_steps (
  id SERIAL PRIMARY KEY,
  step_number INTEGER NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT
);

-- ワークフローステップ初期データ
INSERT INTO workflow_steps (step_number, name) VALUES
  (1, '受講者数の確定'),
  (2, '見積・契約'),
  (3, '助成金計画届の準備'),
  (4, 'キックオフ会議・受講日の打診・アンケート打診・ヒアリング日の打診'),
  (5, '受講日の確定・カリキュラムの調整'),
  (6, '助成金計画届の提出'),
  (7, '助成金申請提出'),
  (8, '研修準備'),
  (9, '研修開始前確認'),
  (10, '研修の実施'),
  (11, '研修完了・修了証発行'),
  (12, '助成金支給申請説明'),
  (13, '助成金支給申請に必要な書類の準備'),
  (14, '助成金支給申請の提出');

-- updated_at 自動更新トリガー
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_profiles_updated_at
  BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_clients_updated_at
  BEFORE UPDATE ON clients
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_orders_updated_at
  BEFORE UPDATE ON orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_training_programs_updated_at
  BEFORE UPDATE ON training_programs
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- インデックス
CREATE INDEX idx_orders_client_id ON orders(client_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_billing_status ON orders(billing_status);
CREATE INDEX idx_orders_subsidy_status ON orders(subsidy_status);
CREATE INDEX idx_training_programs_order_id ON training_programs(order_id);
CREATE INDEX idx_training_sessions_program_id ON training_sessions(training_program_id);
CREATE INDEX idx_training_sessions_date ON training_sessions(session_date);
CREATE INDEX idx_training_sessions_instructor ON training_sessions(instructor);

-- ============================================
-- Row Level Security
-- ============================================

ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE workflow_steps ENABLE ROW LEVEL SECURITY;

-- ユーザープロフィール: 自分のプロフィールは読み書き可、adminは全部見える
CREATE POLICY "Users can read own profile"
  ON user_profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Admins can read all profiles"
  ON user_profiles FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Admins can manage all profiles"
  ON user_profiles FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- クライアント: internal/admin は全権限
CREATE POLICY "Internal users can manage clients"
  ON clients FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role IN ('admin', 'internal'))
  );

-- 受注案件: internal/admin は全権限
CREATE POLICY "Internal users can manage orders"
  ON orders FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role IN ('admin', 'internal'))
  );

-- 研修プログラム: internal/admin は全権限、external は閲覧のみ
CREATE POLICY "Internal users can manage training programs"
  ON training_programs FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role IN ('admin', 'internal'))
  );

CREATE POLICY "External users can read training programs"
  ON training_programs FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'external')
  );

CREATE POLICY "External users can update training program notes"
  ON training_programs FOR UPDATE
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'external')
  )
  WITH CHECK (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'external')
  );

-- 研修日程: internal/admin は全権限、external は閲覧+一部更新
CREATE POLICY "Internal users can manage training sessions"
  ON training_sessions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role IN ('admin', 'internal'))
  );

CREATE POLICY "External users can read training sessions"
  ON training_sessions FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'external')
  );

CREATE POLICY "External users can update training sessions"
  ON training_sessions FOR UPDATE
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'external')
  );

-- ワークフローステップ: 全ユーザー閲覧可、adminのみ編集
CREATE POLICY "All users can read workflow steps"
  ON workflow_steps FOR SELECT
  USING (true);

CREATE POLICY "Admins can manage workflow steps"
  ON workflow_steps FOR ALL
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- ============================================
-- 新規ユーザー登録時にプロフィールを自動作成
-- ============================================
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_profiles (id, email, name, role)
  VALUES (NEW.id, NEW.email, COALESCE(NEW.raw_user_meta_data->>'name', ''), 'internal');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
