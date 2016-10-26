-- Create table
create table APM_USER
(
  ID          NUMBER not null,
  LOGIN_NAME  VARCHAR2(50) not null,
  PASSWORD    VARCHAR2(50) not null,
  PHONE       VARCHAR2(20),
  EMAIL       VARCHAR2(50),
  CREATE_TIME DATE,
  CREATE_USER VARCHAR2(50),
  UPDATE_TIME DATE,
  UPDATE_USER VARCHAR2(50),
  ENABLED     NUMBER(1)
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
comment on column APM_USER.ID
  is '用户ID';
comment on column APM_USER.LOGIN_NAME
  is '登录名';
comment on column APM_USER.PASSWORD
  is '登录密码';
comment on column APM_USER.PHONE
  is '手机号';
comment on column APM_USER.EMAIL
  is '邮件地址';
comment on column APM_USER.CREATE_TIME
  is '创建时间';
comment on column APM_USER.CREATE_USER
  is '创建人';
comment on column APM_USER.UPDATE_TIME
  is '修改时间';
comment on column APM_USER.UPDATE_USER
  is '修改人';
comment on column APM_USER.ENABLED
  is '可用标识(0：不可用；1：可用)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_USER
  add constraint APM_USER primary key (ID)
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