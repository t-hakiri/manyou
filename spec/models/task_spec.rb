require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'titleが30文字以上ならバリデーションが通らない' do
    task = Task.new(title: 'a'*31, content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'contentが255文字以上ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: 'a'*256, deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'deadlineが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: "", status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '', priority: '高')
    expect(task).not_to be_valid
  end

  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '')
    expect(task).not_to be_valid
  end

  it '全ての内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).to be_valid
  end
end