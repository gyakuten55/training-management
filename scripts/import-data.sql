-- ============================================
-- AIリスキリング研修 初期データインポート
-- ============================================

TRUNCATE training_sessions, training_programs, orders, clients CASCADE;

-- ========== 受注管理シート ==========
INSERT INTO clients (name) VALUES ('三笠紙工業（合同C）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, 'ダンボール業者', NULL
FROM clients c WHERE c.name = '三笠紙工業（合同C）' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社タカオカ（合同C）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, 'ダンボール業者', NULL
FROM clients c WHERE c.name = '株式会社タカオカ（合同C）' LIMIT 1;
INSERT INTO clients (name) VALUES ('都一級建設設計事務所（合同D）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '建築事務所', NULL
FROM clients c WHERE c.name = '都一級建設設計事務所（合同D）' LIMIT 1;
INSERT INTO clients (name) VALUES ('アクティオ株式会社 一回目の組') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '指定管理会社', NULL
FROM clients c WHERE c.name = 'アクティオ株式会社 一回目の組' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社ケイズラブ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '12', NULL, '地表地質踏査、精密コアリング、ボアホールスキャナー、高密度電気探査、弾性波探査、地下レーダー、土質試験', NULL
FROM clients c WHERE c.name = '株式会社ケイズラブ' LIMIT 1;
INSERT INTO clients (name) VALUES ('桐生建設株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '建設会社', NULL
FROM clients c WHERE c.name = '桐生建設株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('合同会社NK自動車（合同D）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '新車・中古車販売、車検、修理、サビ止め', NULL
FROM clients c WHERE c.name = '合同会社NK自動車（合同D）' LIMIT 1;
INSERT INTO clients (name) VALUES ('フジミツ株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '12', NULL, '総合食品創造企業', NULL
FROM clients c WHERE c.name = 'フジミツ株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社 小林衛生公社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '廃棄物処理業など衛生管理', NULL
FROM clients c WHERE c.name = '株式会社 小林衛生公社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社協和（合同A）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '板金加工・製造業', NULL
FROM clients c WHERE c.name = '株式会社協和（合同A）' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社チームアール（合同A）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '介護事業：運動特化型デイサービス トレーニングハウスRの運営', NULL
FROM clients c WHERE c.name = '株式会社チームアール（合同A）' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社吉田組（合同A）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '建築、土木その他建設工事', NULL
FROM clients c WHERE c.name = '株式会社吉田組（合同A）' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社あすからいふ倶楽部（合同A）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '葬儀', NULL
FROM clients c WHERE c.name = '株式会社あすからいふ倶楽部（合同A）' LIMIT 1;
INSERT INTO clients (name) VALUES ('大宝工業株式会社（グループ会社含む）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '製造業：車両部品を製造', 'https://docs.google.com/document/d/16telnOXNP2850T7SQUyDoJF5wT7DS67G-1qWliidW_U/edit?tab=t.0#heading=h.l33t9qwzj9wa'
FROM clients c WHERE c.name = '大宝工業株式会社（グループ会社含む）' LIMIT 1;
INSERT INTO clients (name) VALUES ('共和鋼業株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', NULL, '金網・ネットフェンス製造販売', 'https://docs.google.com/document/d/1yEHL6Aj-FlR3YNEPDBiduxUjKnb6xlTeAdvZ2G27QNk/edit?tab=t.0#heading=h.qlf9jmyk4ts2'
FROM clients c WHERE c.name = '共和鋼業株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社阪神フード（グループ会社あり）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', NULL, '食品製造業', NULL
FROM clients c WHERE c.name = '株式会社阪神フード（グループ会社あり）' LIMIT 1;
INSERT INTO clients (name) VALUES ('オグラ金属株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '製造業：プレス板金から溶接・組立', NULL
FROM clients c WHERE c.name = 'オグラ金属株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('ツヅラノフロンティア株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '建設業', 'https://docs.google.com/document/d/1exWM2PrWCnLztmc1VBhYXhMrUxKgRUTgbQwxfJBrvIE/edit?tab=t.0'
FROM clients c WHERE c.name = 'ツヅラノフロンティア株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社セントラル広告') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '広告代理業', NULL
FROM clients c WHERE c.name = '株式会社セントラル広告' LIMIT 1;
INSERT INTO clients (name) VALUES ('和工房株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '不動産事業、リフォームなど', 'https://docs.google.com/document/d/1kYRmdsCUOjY5OYeegur_4WP8r2y-9DIRrUiiCoqKym8/edit?tab=t.0'
FROM clients c WHERE c.name = '和工房株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('Brain Trust from The Sun') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '不動産事業、空き家再生事業', NULL
FROM clients c WHERE c.name = 'Brain Trust from The Sun' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社アバンス') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '保険代理店', NULL
FROM clients c WHERE c.name = '株式会社アバンス' LIMIT 1;
INSERT INTO clients (name) VALUES ('ミッドフォーコミュニケーションズ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '通信サービスおよび通信機器の販売', NULL
FROM clients c WHERE c.name = 'ミッドフォーコミュニケーションズ' LIMIT 1;
INSERT INTO clients (name) VALUES ('JCOM株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '完了', NULL, '通信サービス、ケーブルテレビ', NULL
FROM clients c WHERE c.name = 'JCOM株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('【開発】株式会社エンタ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AI開発', '中止', NULL, NULL, NULL
FROM clients c WHERE c.name = '【開発】株式会社エンタ' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社なかまメディカ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '13', NULL, '介護事業', NULL
FROM clients c WHERE c.name = '株式会社なかまメディカ' LIMIT 1;
INSERT INTO clients (name) VALUES ('協和産業株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '中止', NULL, '不動産業', NULL
FROM clients c WHERE c.name = '協和産業株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社リンクス') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', NULL, '不動産業', '補講中'
FROM clients c WHERE c.name = '株式会社リンクス' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社MJC') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', NULL, NULL, NULL
FROM clients c WHERE c.name = '株式会社MJC' LIMIT 1;
INSERT INTO clients (name) VALUES ('新日本ケミカル・オーナメント') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '4', '1月21日（水）16−18 
2月18日（水）16−18 
3月18日（水）16-18:30 
4月15日（水）16-18:30 
5月20日（水）15-18', '食品衛生包装資材の製造販売', NULL
FROM clients c WHERE c.name = '新日本ケミカル・オーナメント' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社久保村製作所') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '中止', NULL, NULL, NULL
FROM clients c WHERE c.name = '株式会社久保村製作所' LIMIT 1;
INSERT INTO clients (name) VALUES ('マルキン食品株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '5', '日程の確認', 'フードメーカー', '対面希望の調整'
FROM clients c WHERE c.name = 'マルキン食品株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('日本メディカルシステム株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', '追加研修提案', '調剤薬局', '助成金以外; 30万円請求書'
FROM clients c WHERE c.name = '日本メディカルシステム株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社グローバルスタッフ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '13', '1日目 2時間　　　　  2025年12月8日(月) 1:00 PM - 3:00 PM
2日目 2時間 　　　　2026年1月13日(火) 1:00 PM - 3:00 PM
3日目 2時間30分 2026年2月6日(金) 1:00 PM - 3:30 PM
4日目 2時間30分 2026年2月9日(月) 1:00 PM - 3:30 PM
5日目 3時間 　　　　2026年2月10日(火) 1:00 PM - 4:00 PM', '建設業技術支援サービス', '請求書送付; 2025/12/08スタート'
FROM clients c WHERE c.name = '株式会社グローバルスタッフ' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社光洋コーポレーション（グローバルグループ）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', 'グローバルスタッフと合同', '特定技能外国人の登録支援', '請求書送付; 2025/12/08スタート'
FROM clients c WHERE c.name = '株式会社光洋コーポレーション（グローバルグループ）' LIMIT 1;
INSERT INTO clients (name) VALUES ('山田工業株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '13', '令和７年11月17日13時〜15時
令和７年11月28日10時〜12時
令和７年12月1日10時〜12時半
令和７年12月2日10時〜12時半
令和７年12月８日10時〜13時', '家具の製造販売', NULL
FROM clients c WHERE c.name = '山田工業株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('フォーシーズンズ株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', '12/4 修了証発送済み', '高級輸入車正規ディーラー', '修了証発行; フォローアップ研修'
FROM clients c WHERE c.name = 'フォーシーズンズ株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('ネットシステム') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '1日目：12月17日　（水）16:00～18:00
2日目：12月19日　（金）16:00～18:00
3日目：1月7日　（水）15:30～18:00
4日目：1月9日　（金）15:30～18:00
5日目：1月16日　（金）15:00～18:00', 'オフィス空間コンサル', '請求書送付; 12/17スタート'
FROM clients c WHERE c.name = 'ネットシステム' LIMIT 1;
INSERT INTO clients (name) VALUES ('三宅デザイン研究所') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '11月28日（金）15:00〜17:30
12月12日（金）15:00〜18:00
3日目　1月9日15:00-17:30
4日目　1月23日15:00-17:30
5日目　2月6日15:00-18:00', '店舗設計デザイン事務所', '11/28スタート'
FROM clients c WHERE c.name = '三宅デザイン研究所' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社SAR 株式会社電力情報センター') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '1回目　1/20（火）13:00~15:00
2回目　1/21（水）13:00~15:00
3回目　2/3（火） 13:00~15:30
4日目　2/4（水） 13:00~15:30
5日目　2/12(木)　13:00~16:00', '新電力', '11月中に申請; 1/14 スタート'
FROM clients c WHERE c.name = '株式会社SAR 株式会社電力情報センター' LIMIT 1;
INSERT INTO clients (name) VALUES ('プラザオーサカ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '1/19(月)13時-、1/26(月)13時-、2/2(月)13時-、2/10(火)13時-、2/18(水)12時半-', 'ホテル業', '日程待ち'
FROM clients c WHERE c.name = 'プラザオーサカ' LIMIT 1;
INSERT INTO clients (name) VALUES ('ヤブシタ冷熱設備株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', 'ヤブシタ様　研修スケジュール
1回目　1/16　10〜12時
2回目　2/16  15〜17時
3回目　3/17  14:30-17時
4回目　4/16  14:30-17時
5回目　5/18  14-17時', '空調設備・太陽光事業など', 'LINE変態ヒーローズ'
FROM clients c WHERE c.name = 'ヤブシタ冷熱設備株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('ヤブシタホールディングス株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', '1回目　1/16　10〜12時
2回目　2/16  15〜17時
3回目　3/17  14:30-17時
4回目　4/16  14:30-17時
5回目　5/18  14-17時', NULL, NULL
FROM clients c WHERE c.name = 'ヤブシタホールディングス株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('アクティオ株式会社二回目の組') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', '1日目研修　12月15日、12月24日（6時間） 担当：岡田さん
2日目研修　12月17日、12月25日（6時間）担当：松山さん', NULL, '請求書送付済み'
FROM clients c WHERE c.name = 'アクティオ株式会社二回目の組' LIMIT 1;
INSERT INTO clients (name) VALUES ('中日ステンドアート') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', NULL, 'ステンドグラスの製造・販売', '12/2 日程候補もらう'
FROM clients c WHERE c.name = '中日ステンドアート' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社サンブロックワーク（玉組と合同）') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '2026  1日目対面 13時以降調整  2/18   2/19  
2/25   3/4   3/5   3/11   3/12', '製造業', NULL
FROM clients c WHERE c.name = '株式会社サンブロックワーク（玉組と合同）' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社玉組') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '令和8年2月18日（水）13:00~15:00　＠玉組様本社（岡山県玉野市玉原3-7-3）／講師へむさん
令和8年2月25日（水）13:00~15:00　@オンライン／講師松山チーム
令和8年3月4日（水）14:00~16:30　@オンライン／講師松山チーム
令和8年3月5日（木）13:00~15:30　@オンライン／講師松山チーム
令和8年3月11日（水）13:00~16:00　@オンライン／講師松山チーム', '製造業', NULL
FROM clients c WHERE c.name = '株式会社玉組' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社バンソウ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '失注', '3名受講+役員1名で調整', NULL, NULL
FROM clients c WHERE c.name = '株式会社バンソウ' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社プリント工芸') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', NULL, 'プラスチックや金属、アルミ、ガラス等印刷', NULL
FROM clients c WHERE c.name = '株式会社プリント工芸' LIMIT 1;
INSERT INTO clients (name) VALUES ('くるめエネルギー株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', NULL, '新電力', NULL
FROM clients c WHERE c.name = 'くるめエネルギー株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社五光発條') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '3/4,11,18,25,4/8', '製造業', NULL
FROM clients c WHERE c.name = '株式会社五光発條' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社山装') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '14', '【12時間研修】 
1日目：2月6日　10~12時 

2日目：2月12日　10~12時の間で対応可

3日目（グループ1）：2月19日 10-12時半
3日目（グループ2）：2月17日10-12時半

4日目（グループ1）2月26日10-12時半
4日目（グループ2）：2月25日10-12時半

5日目（グループ1）：3月5日10-13時
5日目（グループ2）：3月4日10-13時', '製造業', NULL
FROM clients c WHERE c.name = '株式会社山装' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社IES') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '10', '3月2日（月）10:00~12:00 
令和8年3月12日（木）10:00~12:30
4月１日（水）10:00~12:30 
４月15日（水）10:00~12:30 
５月15日（金）10:00~12:30', '工事', NULL
FROM clients c WHERE c.name = '株式会社IES' LIMIT 1;
INSERT INTO clients (name) VALUES ('OPA') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '5', '"【第1回】
①2/25（水）13:00～17:00　対面
②3/4（水）13:00～17:00　オンライン
【第2回】
①2/27（金）13:00～17:00　対面
②3/11（水）13:00～17:00　オンライン
【第3回】
①3/13（金）13:00～17:00　オンライン
②3/19（木）13:00～17:00　対面"', 'デパート', NULL
FROM clients c WHERE c.name = 'OPA' LIMIT 1;
INSERT INTO clients (name) VALUES ('アサヒ・ドリームクリエイト株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '日程】 ∙ 5/27（水）：2H：13:30〜15:30 ∙ 6/10（水）：2H：13:30〜15:30 ∙ 6/24（火）：2.5H：13:30〜16:00 ∙ 7/8（火）：2.5H：13:30〜16:00 ∙ 7/22（火）：3H：13:30〜16:30 【参加者】 清水 濱田 松本 池田 上野​​​​​​​​​​​​​​​​', NULL, NULL
FROM clients c WHERE c.name = 'アサヒ・ドリームクリエイト株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('アオヤギ株式会社') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '5', '・1回目：4月30日 （木）13:00～15:00（2時間）
・2回目：5月12日 （火）13:00～15:00（2時間）
・3回目：5月20日 （水）13:00～15:30（2時間半）
・4回目：5月26日 （火）13:00～15:30（2時間半）
・5回目：6月02日 （火）13:00～16:00（3時間）', NULL, NULL
FROM clients c WHERE c.name = 'アオヤギ株式会社' LIMIT 1;
INSERT INTO clients (name) VALUES ('プライムワーク') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '1', '6月2日    火 13-15
 6月16日    火 13-15
 6月30日    火 13-1530
 7月14日    火 13-1530
 7月28日    火 13-16', NULL, NULL
FROM clients c WHERE c.name = 'プライムワーク' LIMIT 1;
INSERT INTO clients (name) VALUES ('ヤマト住建') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '7', '①5/12　16～18
②5/29　13～15
③後ほど
④6/30　14～16
⑤7/14　16～18
⑥7/24　後ほど', NULL, NULL
FROM clients c WHERE c.name = 'ヤマト住建' LIMIT 1;
INSERT INTO clients (name) VALUES ('ワン・プレイス') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '5', NULL, NULL, NULL
FROM clients c WHERE c.name = 'ワン・プレイス' LIMIT 1;
INSERT INTO clients (name) VALUES ('ダイワロイヤルゴルフ') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, training_schedule_text, memo, notes)
SELECT c.id, 'AIリスキリング', '1', NULL, NULL, NULL
FROM clients c WHERE c.name = 'ダイワロイヤルゴルフ' LIMIT 1;
INSERT INTO clients (name) VALUES ('株式会社FCC') ON CONFLICT DO NOTHING;
INSERT INTO orders (client_id, product_type, status, order_date, order_amount)
SELECT c.id, 'Hero AIVO', '10', '2025-12-10', 55000
FROM clients c WHERE c.name = '株式会社FCC' LIMIT 1;

-- ========== 発注管理シート ==========
INSERT INTO clients (name, url, industry) VALUES ('大宝工業株式会社', 'https://www.daiho-gr.co.jp/', '各種プラスチック製品および金型の製造販売');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '大宝工業株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '全員', '12時間（5日間）', 'オンライン', 'オンライン', 17, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/11rsOl_YeTyTSoxlZ1EdKvRgg17uzCKJcBJ92uSRMySE/edit?usp=sharing', '研修後インタビュー
https://docs.google.com/document/d/16telnOXNP2850T7SQUyDoJF5wT7DS67G-1qWliidW_U/edit?tab=t.0#heading=h.l33t9qwzj9wa'
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '大宝工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）', 'https://kyowa-kiryu.com/
https://yoshidagumi-inc.jp/
https://www.aska-ceremo.co.jp/club/index.html
https://team-r.co.jp/', '介護・建設・冠婚葬祭');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', 'マネージャー層・バックオフィス', '12時間（5日間）', 'オンライン', 'オンライン', 14, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, 'https://docs.google.com/document/d/1yEHL6Aj-FlR3YNEPDBiduxUjKnb6xlTeAdvZ2G27QNk/edit?tab=t.0#heading=h.qlf9jmyk4ts2'
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '4社合同（協和・吉田組・あすからいふ倶楽部・チームアール）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社 阪神フード', 'https://www.hanshinfood.com/', '寿司ネタ、惣菜等の水産加工及び販売');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社 阪神フード' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '全員', '12時間（5日間）', '兵庫県川西市加茂６丁目８９番地１', '対面', 20, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1TdY-KqKnwGp1KOFuk6SrDiNmYX_A_4YNCG3sKvR1zQY/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社 阪神フード'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('共和鉱業株式会社', 'https://kyowakogyo.net/', 'ひし形金網製造');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '共和鉱業株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '社長・現場スタッフ・バックオフィス', '12時間（5日間）', 'オンライン', 'オンライン', 7, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '共和鉱業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('NK自動車様/都一級建設設計事務所', 'https://nkjidousya.com/
https://miyako19.com/', '建築関係建設コンサルタント業務
補償関係コンサルタント業務');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'NK自動車様/都一級建設設計事務所' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'NK自動車様/都一級建設設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社小林衛生公社', 'https://kobayashi-eco.co.jp/', '廃棄物処理業');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社小林衛生公社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1FBOYf6HTBXMdrub6lIbA35_yyD4kBvHNiTQaXjcJc4w/edit?resourcekey=&gid=829234229#gid=829234229', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社小林衛生公社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社タカオカ/三笠紙工業株式会社', 'https://takaoka-db.co.jp/
https://atcompany.jp/micasa/', '段ボール及び段ボール箱の製造・販売');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1NyFI1p2FcKORHwuotPdwucbKho_KrFXwq2CppX80NrY/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社タカオカ/三笠紙工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.kiriken.co.jp/', industry = '建築工事全般' WHERE name = '桐生建設株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1BTx7jw_ffo0dasuw0Syu-Tyd98WEnVgR0UoJe0BOJlI/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '桐生建設株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('アクティオ株式会社', 'https://www.actio.co.jp/', '指定管理者制度に基づく公の施設の管理受託');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'アクティオ株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '全従業員からの選抜', '24時間（4日間）', '大阪府大阪市淀川区木川東4-8-4', '対面', 90, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アクティオ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://nakamedi.com/', industry = '訪問マッサージ・鍼灸・機能訓練' WHERE name = '株式会社なかまメディカ';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', 'マネージャー層', '12時間（5日間）', 'オンライン', 'オンライン', 10, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1doBlicrFazAqa4GZ8v1raYhX7-kQkws2PFeqLx-Gz_g/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-10-02', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-10-09', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-10-16', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-10-30', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-11-06', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社なかまメディカ'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.make-joy-corporation.co.jp/', industry = '不動産デベロッパー' WHERE name = '株式会社MJC';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '営業/経理/総務', '12時間（5日間）', '大阪市福島区福島6-4-10ウエストビル', '対面', 5, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-10-09', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, '水谷(外部)'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-11-13', NULL, NULL, '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-11-27', '14:00', '16:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-12-11', '14:00', '17:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社MJC'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.fujimitz.co.jp/', industry = '計測機器等の科学計測機器を販売' WHERE name = 'フジミツ株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '製造スタッフ/マネージャー', '12時間（5日間）', 'オンライン', 'オンライン', 8, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-10-10', NULL, NULL, '宮崎'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-10-17', NULL, NULL, '宮崎'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-10-24', NULL, NULL, '宮崎'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-10-31', NULL, NULL, '宮崎'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-11-07', NULL, NULL, '宮崎'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フジミツ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://linx-osaka.co.jp/lp/investment/', industry = '不動産' WHERE name = '株式会社リンクス';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '営業/管理', '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1FKxww0d_3XpjIiCThqO8Vrvrx_W9Wjc1dQZkkPHQ91o/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-10-24', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-10-31', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-11-07', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-11-14', NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-11-21', '14:00', '17:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社リンクス'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.forseasons.jp', industry = '自動車販売事業' WHERE name = 'フォーシーズンズ株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', 'https://docs.google.com/spreadsheets/d/1wJwL_VXjmqgjhB_OgdViX0M36djRg68P/edit?usp=drive_link&ouid=106421029753785522681&rtpof=true&sd=true', '12時間（3日間)', '大阪市北区西天満5-2-18 三共ビル東館10階', '対面', 12, NULL, NULL, 'https://drive.google.com/file/d/1TvWnrXVgtqBfodj7keZy7N9_2sd_pBt2/view?usp=sharing', NULL, 'https://www.canva.com/design/DAG2xwkO_DM/YVjWYOW6kj4fjbdnRIogeg/edit?utm_content=DAG2xwkO_DM&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton', NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-10-27', NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-10-28', NULL, NULL, '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-11-14', NULL, NULL, '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'フォーシーズンズ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://yamada-technical.co.jp/profile/', industry = '舗装工事' WHERE name = '山田工業株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', NULL, NULL, NULL, 'なし', NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1tp74Vw-lRLlpDfluXVn7ObrhtCR-JhsXkMsr-XJS2Ao/edit?usp=sharing', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-11-17', '13:00', '15:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-11-28', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-12-01', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-12-02', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-12-08', '10:00', '13:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '山田工業株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('三宅デザイン設計事務所', 'https://www.miyake-design.com/', 'デザイン設計・制作施工ならびに各種施設・イベントの活性化運営管理');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '三宅デザイン設計事務所' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', '大阪市西区北堀江1-2-19 アステリオ北堀江 THE METRO TOWER 4F', '対面', 5, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-11-28', '15:00', '17:30', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-12-15', '15:00', '17:00', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-01-09', '15:00', '17:30', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-01-23', '15:00', '17:30', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-02-06', '15:00', '18:00', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '三宅デザイン設計事務所'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社グロバールスタッフ
株式会社光洋コーポレーション', 'http://www.global-globe.com/service/service01.html', '人材派遣');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '12時間（5日間）', 'オンライン', 'オンライン', NULL, NULL, NULL, 'なし', 'https://docs.google.com/spreadsheets/d/1hgqRozbNnfbITI4V4ZPg99AbMdoqAQgvE4iCSsMAIXM/edit?resourcekey=&gid=1181822357#gid=1181822357', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-12-08', '13:00', '15:00', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-01-13', '13:00', '15:00', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-02-06', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-02-09', '13:00', '15:30', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-02-10', '13:00', '16:00', '森内'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社グロバールスタッフ
株式会社光洋コーポレーション'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('(一社)全旅協大阪府旅行業協会', 'https://anta-osaka.or.jp/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '(一社)全旅協大阪府旅行業協会' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', NULL, '3時間（2日間）', '難波市民学習センター（OCATビル4階）', '対面', 40, '中野', '2025-11-10', 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-12-10', '15:00', '16:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-01-22', '15:00', '16:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '(一社)全旅協大阪府旅行業協会'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('ネットシステム株式会社', 'https://www.netsystem-j.co.jp/', 'オフィス環境整備');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'ネットシステム株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', NULL, '12時間（5日間）', 'オンライン', 'オンライン', 5, NULL, NULL, 'なし', 'https://docs.google.com/spreadsheets/d/1VNTynHq0G5m2pM9pZEz6ghcrvb-U6V48Is0NRsjwzsw/edit?usp=sharing', NULL, NULL, 'https://docs.google.com/spreadsheets/d/1nuZE4DPuPz0LpUzljUccCgzIdqJvj914i6J71vuvelc/edit?resourcekey&usp=forms_web_b&urp=linked#gid=137597988', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-12-17', '16:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-12-19', '16:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-01-07', '15:30', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-01-09', '15:30', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-01-16', '15:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ネットシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社', 'http://yabushita-reisetsu.co.jp/', '設備工事');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 3, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-01-16', '10:00', '12:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-02-16', '15:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-03-17', '14:30', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-04-16', '14:30', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-05-18', '14:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤブシタ冷熱設備株式会社
ヤブシタホールディングス株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.jmsys.co.jp/', industry = '医療関係' WHERE name = '日本メディカルシステム株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '4時間（1日間）', '東京都江戸川区東葛西6-27-15', '対面', NULL, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-12-09', '10:00', '14:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, NULL, NULL, NULL, NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '日本メディカルシステム株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社SAR/株式会社電力情報システム', 'https://denryoku-joho.com/', '電力コンシェルジュ（電力情報センター）');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社SAR/株式会社電力情報システム' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 2, NULL, NULL, 'なし', 'https://docs.google.com/spreadsheets/d/1sOg1m6RWiL39iTCQuCcVfWaEu7j3JmBL2vZObbUtT88/edit?resourcekey&usp=forms_web_b&urp=initialLink#gid=677238968', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-01-20', '13:00', '15:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-01-21', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-02-03', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-02-04', '13:00', '16:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-02-12', '13:00', '16:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社SAR/株式会社電力情報システム'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.marukinfoods.co.jp/' WHERE name = 'マルキン食品株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', NULL, '対面希望', '対面', 5, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/10jCPwFUGd6ohNkMMNda57dMf-hKhMFjYWjcVeP_SCz4/edit?usp=sharing', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'マルキン食品株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社プリント工芸（くるめエネルギー合同）', 'https://printkougei.co.jp/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 3, NULL, NULL, 'なし', 'https://docs.google.com/spreadsheets/d/1ztEOcsuS446CPdw9q-QFspNw13CeC8doe-DUWvIq0Uc/edit?resourcekey=&gid=328901480#gid=328901480', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-03-04', '09:30', '11:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-03-18', '09:30', '11:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-25', '09:30', '12:00', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-04-01', '09:30', '12:00', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-04-15', '09:30', '12:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プリント工芸（くるめエネルギー合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('くるめエネルギー株式会社（プリント工芸合同）', NULL, NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-03-04', '09:30', '11:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-03-18', '09:30', '11:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-25', '09:30', '12:00', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-04-01', '09:30', '12:00', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-04-15', '09:30', '12:30', '柏木'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'くるめエネルギー株式会社（プリント工芸合同）'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://bansow.co.jp/' WHERE name = '株式会社バンソウ';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', NULL, NULL, 'オンライン', 5, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社バンソウ'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('新日本ケミカルオーナメント株式会社', 'https://www.sncom.jp/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '新日本ケミカルオーナメント株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 6, NULL, NULL, 'なし', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-01-21', '16:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-02-18', '16:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-03-18', '16:00', '18:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-04-15', '16:00', '18:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-05-20', '15:00', '18:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '新日本ケミカルオーナメント株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社中日ステンドアート', 'https://www.studio-csa.com/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社中日ステンドアート' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'ハイブリット？', 'オンライン', 5, NULL, '2025-01-07', 'なし', 'https://docs.google.com/spreadsheets/d/1ZF6x5QdfkiZb2LIn6XcWrzqorsCT6iMMUDqQb0L6rD0/edit?usp=sharing', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社中日ステンドアート'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-01-26', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社中日ステンドアート'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-02-09', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社中日ステンドアート'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-02-17', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社中日ステンドアート'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社プラザオーサカ', 'https://plazaosaka.com/', 'ホテル・レストラン運営');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社プラザオーサカ' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 7, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1j6ijAdl7hKX9zDdCAcnlVdncFsFJDjryybDRgVV298U/edit?usp=sharing', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2025-01-19', '13:00', '15:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2025-01-26', '13:00', '15:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2025-02-02', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2025-02-10', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2025-02-18', '12:30', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プラザオーサカ'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('（一社）全旅協大阪府旅行業協会', '開催地：(一社)全旅協大阪府旅行業協会
https://anta-osaka.or.jp/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '（一社）全旅協大阪府旅行業協会' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '研修完了', '旅行業社向け', NULL, NULL, 'オンライン', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '（一社）全旅協大阪府旅行業協会'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社山装（Aグループ）', 'https://yamaso-y.co.jp/', '製造業');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社山装（Aグループ）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '全社セミナー＋12時間(5日間)', 'オンライン', 'オンライン', 15, NULL, NULL, 'https://docs.google.com/document/d/1y1Ei3b1HWIsJFXOi8Cg29kezBjsGXFbqBSY9ftOHv3k/edit?usp=sharing、https://docs.google.com/document/d/1aykQQjFR9djhJadI65QG76xb2936BIVeeoeosLYAr78/edit?usp=sharing', 'https://docs.google.com/spreadsheets/d/1wcOpKtx91Fuu-ol7oeQxthUnPUdqnqTquCxT507hS8Q/edit?usp=sharing', NULL, 'https://drive.google.com/drive/folders/1PAA3OUwBa3SUZ1BrSEKyOznH4JnmBJo_?usp=drive_link', 'https://docs.google.com/spreadsheets/d/1EEmkkToxx1d_YklI1M5jsApd6KwmuYzb_y4G6JeffkQ/edit?resourcekey=&gid=1608220756#gid=1608220756', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-02-06', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-02-12', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-02-19', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-02-26', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-03-05', '10:00', '13:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Aグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社山装（Bグループ）', 'https://yamaso-y.co.jp/', '製造業');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社山装（Bグループ）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '全社セミナー＋12時間(5日間)', 'オンライン', 'オンライン', 15, NULL, NULL, 'https://docs.google.com/document/d/1y1Ei3b1HWIsJFXOi8Cg29kezBjsGXFbqBSY9ftOHv3k/edit?usp=sharing、https://docs.google.com/document/d/1aykQQjFR9djhJadI65QG76xb2936BIVeeoeosLYAr78/edit?usp=sharing', 'https://docs.google.com/spreadsheets/d/1XzgIBiUP-oZYo9oHbz-4EMAqwg9STa_ayhbtiW8Wx2Y/edit?usp=sharing', NULL, 'https://drive.google.com/drive/folders/1PAA3OUwBa3SUZ1BrSEKyOznH4JnmBJo_?usp=drive_link', 'https://docs.google.com/spreadsheets/d/1EEmkkToxx1d_YklI1M5jsApd6KwmuYzb_y4G6JeffkQ/edit?resourcekey=&gid=1608220756#gid=1608220756', NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-02-06', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-02-12', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-02-17', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-02-25', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-03-04', '10:00', '13:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社山装（Bグループ）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('産經新聞社', 'https://www.sankei.jp/', 'メディア（新聞）');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '産經新聞社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', NULL, NULL, 'オンライン', NULL, NULL, NULL, 'https://docs.google.com/document/d/1sqkwYB6DAx5iYUX2HLa9tUqkW4e2F66E-r9PozaJuOg/edit?usp=sharing', NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '産經新聞社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-01-27', '11:30', '13:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '産經新聞社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社玉組／サンブロックワークス', NULL, NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社玉組／サンブロックワークス' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'リアル・オンライン', 'ハイブリッド', 9, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1KkGv_YjG36kR6zi1Fze3dQ4D22bnnd3yTQnzjZvzFYo/edit?usp=sharing', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-02-18', '13:00', '15:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-02-25', '13:00', '15:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-04', '14:00', '16:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-03-05', '13:00', '15:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-03-11', '13:00', '16:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社玉組／サンブロックワークス'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://ies-japan.co.jp/' WHERE name = '株式会社IES';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'オンライン', 'オンライン', 12, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1JZdrIUVdoTDQqPKbuJrjVEfQ7yYad3y74Yii2kZN1ac/edit?usp=sharing', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-03-02', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-03-12', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-04-01', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-04-15', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-05-15', '10:00', '12:30', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社IES'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://www.goko-spring.co.jp/', industry = '製造業' WHERE name = '株式会社五光発條';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（5日間）', 'リアル・オンライン', 'ハイブリッド', 8, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/14sHwdR2b_G94kmHR819kSemViaPTBuKGGbRCtPI658k/edit?resourcekey=&gid=1354285518#gid=1354285518', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-03-04', '10:00', '12:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-03-11', '10:00', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-18', '09:30', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-03-25', '09:30', '12:00', '中野'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-04-08', '09:00', '12:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社五光発條'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社OPA（コーポレート部門A）', 'https://www.opa.gr.jp/', 'ショッピングセンター、各種商業施設の開発・運営など');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社OPA（コーポレート部門A）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（3日間）第1・2回目対面', 'リアル・オンライン', 'ハイブリッド', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門A）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-02-25', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門A）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-02-27', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門A）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-13', '13:00', '17:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門A）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社OPA（コーポレート部門B）', 'https://www.opa.gr.jp/', 'ショッピングセンター、各種商業施設の開発・運営など');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社OPA（コーポレート部門B）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（3日間）第3回目対面', 'リアル・オンライン', 'ハイブリッド', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門B）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-03-04', '13:00', '17:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門B）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-03-11', '13:00', '17:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門B）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-03-19', '13:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（コーポレート部門B）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社OPA（店舗部門）全部オンライン', 'https://www.opa.gr.jp/', 'ショッピングセンター、各種商業施設の開発・運営など');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社OPA（店舗部門）全部オンライン' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', NULL, NULL, 'オンライン', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社OPA（店舗部門）全部オンライン'
ORDER BY o.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://pop-asahi.com/', industry = '販促コンサルティング、企画デザイン' WHERE name = 'アサヒ・ドリームクリエイト株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間', 'オンライン', 'オンライン', 5, NULL, NULL, NULL, 'https://docs.google.com/spreadsheets/d/1utAtMQzUI9c3ZR4bmYQ4UoJvVHwCiNdjGezsGhfXDA8/edit?gid=1262870750#gid=1262870750', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-05-27', '13:30', '15:30', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-06-10', '13:30', '15:30', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-06-24', '13:30', '16:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-07-08', '13:30', '16:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-07-22', '13:30', '16:30', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アサヒ・ドリームクリエイト株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
UPDATE clients SET url = 'https://aoyagi-f.co.jp/', industry = 'ドキュメント関連のBPO（業務アウトソーシング）、印刷' WHERE name = 'アオヤギ株式会社';
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間', 'オンライン', 'オンライン', 5, NULL, '2026-04-21', NULL, 'https://docs.google.com/spreadsheets/d/1jyMD2lz6h6RWkKO0TyNW1q11RaQ_7ldQhimKCahRCV4/edit?usp=drive_link', NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-04-30', '13:00', '15:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-05-12', '13:00', '15:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-05-20', '13:00', '15:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-05-26', '13:00', '15:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-06-02', '13:00', '16:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'アオヤギ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('ヤマト住建株式会社（オンライン）', 'https://www.yamatojk.co.jp/', '建設業');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'ヤマト住建株式会社（オンライン）' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（6日間）', 'オンライン', 'オンライン', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-05-12', '16:00', '18:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-05-29', '13:00', '15:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-06-26', '13:00', '15:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-06-30', '14:00', '16:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-07-14', '16:00', '18:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 6, '2026-07-24', '13:00', '15:30', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ヤマト住建株式会社（オンライン）'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社プライムワーク', 'https://prime-work.co.jp/', '人材派遣');
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社プライムワーク' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間', 'オンライン', 'オンライン', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-06-02', '13:00', '15:00', NULL
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-06-16', '13:00', '15:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-06-30', '13:00', '15:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-07-14', '13:00', '15:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-07-28', '13:00', '16:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社プライムワーク'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('ダイワロイヤルゴルフ株式会社', 'https://www.daiwaroyalgolf.jp/', NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = 'ダイワロイヤルゴルフ株式会社' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', '社員向け', '12時間（3日間）対面：1日目', '（対面）
令和8年5月22日（金）10:00~12:00,13:00〜17:00　@東京本社

（オンライン）
令和8年6月19日（金）14:00~17:00
令和8年7月17日（金）14:00~17:00', 'ハイブリッド', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ダイワロイヤルゴルフ株式会社'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-05-22', '10:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ダイワロイヤルゴルフ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-06-19', '14:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ダイワロイヤルゴルフ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-07-17', '14:00', '17:00', '松山'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = 'ダイワロイヤルゴルフ株式会社'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO clients (name, url, industry) VALUES ('株式会社ワン・プレイス', NULL, NULL);
INSERT INTO orders (client_id, product_type, status)
SELECT c.id, 'AIリスキリング', '1'
FROM clients c WHERE c.name = '株式会社ワン・プレイス' LIMIT 1;
INSERT INTO training_programs (order_id, status, training_target, duration_text, venue, venue_type, num_participants, pre_meeting_person, pre_meeting_date, meeting_notes_url, pre_survey_url, training_materials_url, archive_url, post_survey_url, notes)
SELECT o.id, '受注済', NULL, NULL, NULL, 'オンライン', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM orders o
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY o.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 1, '2026-05-26', '10:00', '12:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 2, '2026-06-04', '10:00', '12:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 3, '2026-06-11', '10:00', '12:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 4, '2026-06-18', '10:00', '12:30', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY tp.created_at DESC LIMIT 1;
INSERT INTO training_sessions (training_program_id, day_number, session_date, start_time, end_time, instructor)
SELECT tp.id, 5, '2026-06-25', '10:00', '13:00', '木之下'
FROM training_programs tp
JOIN orders o ON tp.order_id = o.id
JOIN clients c ON o.client_id = c.id
WHERE c.name = '株式会社ワン・プレイス'
ORDER BY tp.created_at DESC LIMIT 1;

-- Done!
