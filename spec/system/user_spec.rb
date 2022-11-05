require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録のテスト' do
    before do
      FactoryBot.create(:user)
    end
    context 'ユーザーを新規作成した場合' do
      it '登録したユーザーが表示される' do
        visit new_user_path
        fill_in '名前',	with: 'name_1'
        fill_in 'メールアドレス',	with: 'e@mail.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on '登録する'
        expect(page).to have_content 'name_1'
        expect(page).to have_content 'e@mail.com'
      end
    end
    context 'ユーザーがログインせずにタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit new_user_path
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'メールアドレス',	with: "hoge@hoge.com"
      fill_in 'パスワード',	with: 'password'
      click_on 'ログインする'
    end
    context 'ログインした場合' do
      it 'ログイン一覧画面が表示される' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'タイトル'
        expect(page).to have_content 'ステータス'
      end
    end
    context 'ログインした場合' do
      it '自分の詳細画面に飛べる' do
        click_on 'プロフィール'
        expect(page).to have_content 'のページ'
        expect(page).to have_content 'hoge'
        expect(page).to have_content 'hoge@hoge.com'
      end
    end
    context 'ログインした場合' do
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(5)
        expect(page).to have_content 'アクセスできません'
      end
    end
    context 'ログインした場合' do
      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      visit new_session_path
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできること' do
        FactoryBot.create(:second_user)
        fill_in 'メールアドレス',	with: "fuga@fuga.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        expect(page).to have_content '管理者一覧'
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面にアクセスできないこと' do
        FactoryBot.create(:user)
        fill_in 'メールアドレス',	with: "hoge@hoge.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        expect(page).to have_content '管理権限がありません'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの新規登録ができること' do
        FactoryBot.create(:second_user)
        fill_in 'メールアドレス',	with: "fuga@fuga.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        click_on 'ユーザーを新規作成'
        fill_in '名前',	with: 'name_2'
        fill_in 'メールアドレス',	with: 'ee@mail.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        check '管理者権限'
        click_on '登録する'
        expect(page).to have_content '登録しました'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの詳細画面にアクセスできること' do
        FactoryBot.create(:second_user)
        fill_in 'メールアドレス',	with: "fuga@fuga.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        click_on '詳細'
        expect(page).to have_content 'のページ'
        expect(page).to have_content '管理者権限'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの編集画面にアクセスできること' do
        FactoryBot.create(:second_user)
        fill_in 'メールアドレス',	with: "fuga@fuga.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        click_on '編集'
        fill_in '名前',	with: 'fugafuga'
        click_on '更新する'
        expect(page).to have_content '更新しました'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの削除ができること' do
        FactoryBot.create(:second_user)
        fill_in 'メールアドレス',	with: "fuga@fuga.com"
        fill_in 'パスワード',	with: 'password'
        click_on 'ログインする'
        click_on 'ユーザー一覧'
        click_on '削除'
        expect(page).to have_content '削除'
      end
    end
  end
end