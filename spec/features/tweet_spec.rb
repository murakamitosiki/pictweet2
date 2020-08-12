require 'rails_helper'

feature 'tweet', type: :feature do#describeがfeatureに変わっている。tweetについてfeature(統合テスト)する。
  let(:user) { create(:user) }#create(:user) を短縮形にして(:user)として以下で使う

  scenario 'ユーザー情報が更新されていること' do#itがscenarioになっている
    # ログイン前には投稿ボタンがない
    visit root_path #root_path(トップページ)にvisit(訪問する)
    expect(page).to have_no_content('投稿する')#ログインしてないので、投稿するボタンはない

    # ログイン処理
    visit new_user_session_path#新しいuserを登録する
    fill_in 'user_email', with: user.email# fill_inでuser.emailを入力する。
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click#送信ボタン
    expect(current_path).to eq root_path#current_path(今いるところ)がログイン後のページで、root_pathがログイン前のページになる。この二つは両方とも同じページを指している事を記載している文
    expect(page).to have_content('投稿する')#ログインしているので、投稿ボタンがある。

    # ツイートの投稿
    expect {
      click_link('投稿する')#ツイートの投稿ボタンがある。
      expect(current_path).to eq new_tweet_path#current_pathのURLとnew_tweet_path(railsroutesで調べたコントローラーアクション)と等しい
      fill_in 'image', with: 'https://s.eximg.jp/expub/feed/Papimami/2016/Papimami_83279/Papimami_83279_1.png'#写真入力
      fill_in 'text', with: 'フィーチャスペックのテスト'#文字入力
      find('input[type="submit"]').click#送信ボタン
    }.to change(Tweet, :count).by(1)#tweetが増えるか
  end
end