class User < ApplicationRecord
  before_destroy :destroy_action
  before_update :update_action
  has_many :tasks, dependent: :destroy # "dependent: :destroy" はレコード削除時に関連すtasksも削除する(callbackあり)
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  private

  def destroy_action
    # 最後の1管理者の場合は削除できない。(admin:trueの数が1以下になってはいけない, 現状自分の最後の1人ということは今自分のadminがtrueであるはず)
    if User.where(admin: true).count == 1
      user = User.where(admin: true)
      if user[0] == self
      throw :abort
      end
    end
  end

  def update_action
    # 最後の1管理者の場合は管理者をfalseに変更できない。(admin:trueの数が1以下になってはいけないので、admin trueが1人の時のupdateの時に、admin falseにできてないけない)
    if User.where(admin: true).count == 1 && self.admin == false
      user = User.where(admin: true)
      if user[0] == self
      errors.add(:user, '更新にエラーがあります。現在あなたのみが管理人のため管理人から外れることはできません。')
      throw :abort
      end
    end
  end

end
