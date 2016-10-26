-- Create table
create table APM_POLICY_USER
(
  ALARM_POLICY_ID NUMBER not null,
  USER_ID         NUMBER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 8
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column APM_POLICY_USER.ALARM_POLICY_ID
  is '报警策略ID(关联APM_ALARM_POLICY.ID)';
comment on column APM_POLICY_USER.USER_ID
  is '用户ID(关联APM_USER.ID)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_POLICY_USER
  add constraint APM_POLICY_USER primary key (ALARM_POLICY_ID, USER_ID)
  using index 
  tablespace CATAPAY_TS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );