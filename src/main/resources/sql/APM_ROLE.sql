-- Create table
create table APM_ROLE
(
  ID        NUMBER not null,
  ROLE_NAME VARCHAR2(10) not null
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
comment on column APM_ROLE.ID
  is '角色ID';
comment on column APM_ROLE.ROLE_NAME
  is '角色名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_ROLE
  add constraint APM_ROLE primary key (ID)
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