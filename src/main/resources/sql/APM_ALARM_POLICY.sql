-- Create table
create table APM_ALARM_POLICY
(
  ID                 NUMBER not null,
  ALARM_POLICY_NAME  VARCHAR2(50) not null,
  SEND_FLAG          NUMBER(1) not null,
  SEND_MESSAGE       NUMBER(1) default 0,
  SEND_EMAIL         NUMBER(1) default 0,
  SEND_PHONE         NUMBER(1) default 0,
  ALARM_POLICY_LEVEL NUMBER(1) default 0,
  ALARM_POLICY_TYPE  NUMBER(1) default 0,
  DELETE_FLAG        NUMBER(1) not null
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
comment on column APM_ALARM_POLICY.ALARM_POLICY_NAME
  is '报警策略名称';
comment on column APM_ALARM_POLICY.SEND_FLAG
  is '是否发送标识(0：不发送；1：发送)';
comment on column APM_ALARM_POLICY.SEND_MESSAGE
  is '是否发送站内信标识(0：不发送；1：发送)';
comment on column APM_ALARM_POLICY.SEND_EMAIL
  is '是否发送邮件标识(0：不发送；1：发送)';
comment on column APM_ALARM_POLICY.SEND_PHONE
  is '是否发送短信标识(0：不发送；1：发送)';
comment on column APM_ALARM_POLICY.ALARM_POLICY_LEVEL
  is '达到报警级别(1：正常；2：警告；3：过高)';
comment on column APM_ALARM_POLICY.ALARM_POLICY_TYPE
  is '报警策略类型(1:服务策略；2:系统策略)';
comment on column APM_ALARM_POLICY.DELETE_FLAG
  is '是否可删除标识(0:不可删除；1:可删除)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_ALARM_POLICY
  add constraint APM_ALARM_POLICY primary key (ID)
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