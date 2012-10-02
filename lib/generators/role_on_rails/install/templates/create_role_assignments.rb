class CreateRoleAssignments < ActiveRecord::Migration

  def self.up
    create_table :role_assignments do |t|
      t.references  :user
      t.references  :role
      t.boolean     :disabled,    :default => false
      t.datetime    :created_at,  :null => false
      t.datetime    :updated_at,  :null => false
      t.references  :context,     :polymorphic => true
    end

    add_index :role_assignments, [:context_type, :context_id, :role_id, :user_id], :name => "index_role_assignments_on_context"
    add_index :role_assignments, [:role_id], :name => "index_role_assignments_on_role_id"
    add_index :role_assignments, [:user_id], :name => "index_role_assignments_on_user_id"
  end

  def self.down
    drop_table :role_assignments
  end

end
