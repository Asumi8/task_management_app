require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  describe 'ラベル付け機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:label) { FactoryBot.create(:label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    let!(:third_label) { FactoryBot.create(:third_label) }
    let!(:labeling) { FactoryBot.create(:labeling, task: task, label: label) }
    before do
      visit new_session_path
      fill_in 'メールアドレス',	with: "hoge@hoge.com"
      fill_in 'パスワード',	with: 'password'
      click_on 'ログインする'
    end
    context '複数のラベルを新規登録する場合' do
      it '作成したタスクにラベルが複数登録される' do
        click_on '新規作成'
        sleep(2)
        fill_in 'タイトル',	with: 'title_1'
        fill_in '内容',	with: 'content_1'
        fill_in '終了期限', with: Time.new(2022, 8, 1)
        select '完了', from: 'ステータス'
        select '高', from: '優先順位'
        check 'sample_1'
        check 'sample_2'
        click_on '登録する'
        expect(page).to have_content 'sample_1'
        expect(page).to have_content 'sample_2'
      end
    end
    context 'ラベルを編集する場合' do
      it '作成したタスクのラベルを一つ削除して追加で一つラベルを登録する' do
        click_on '編集'
        sleep(2)
        uncheck 'sample_2'
        check 'sample_3'
        click_on '更新する'
        page.save_screenshot 'sc_1.png'
        expect(page).to have_content 'sample_1'
        expect(page).to have_content 'sample_3'
      end
    end
  end
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:label) { FactoryBot.create(:label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    let!(:labeling) { FactoryBot.create(:labeling, task: task, label: label) }
    before do
      visit new_session_path
      fill_in 'メールアドレス',	with: "hoge@hoge.com"
      fill_in 'パスワード',	with: 'password'
      click_on 'ログインする'
    end
    context 'ラベル検索をした場合' do
      it "ラベルと一致するタスクが絞り込まれる" do
        select 'sample_2', from: 'task[label_id]' 
        click_on "検索"
        expect(page).to have_content 'sample_2' #変更
      end
    end
  end
end 