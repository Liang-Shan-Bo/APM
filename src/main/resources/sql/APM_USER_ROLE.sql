-- Create table
create table APM_USER_ROLE
(
  USER_ID NUMBER not null,
  ROLE_ID NUMBER not null
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
comment on column APM_USER_ROLE.USER_ID
  is '用户ID(关联APM_USER.ID)';
comment on column APM_USER_ROLE.ROLE_ID
  is '角色ID(关联APM_ROLE.ID)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_USER_ROLE
  add constraint APM_USER_ROLE primary key (USER_ID, ROLE_ID)
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