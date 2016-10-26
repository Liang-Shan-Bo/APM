-- Create table
create table APM_ALARM_SEND
(
  ID           NUMBER not null,
  ALRAM_LOG_ID NUMBER,
  USER_ID      NUMBER not null,
  SEND_TIME    DATE,
  READ_FLAG    NUMBER(1),
  MESSAGE      VARCHAR2(512),
  TITLE        VARCHAR2(512)
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
comment on column APM_ALARM_SEND.ID
  is 'ID';
comment on column APM_ALARM_SEND.ALRAM_LOG_ID
  is '报警日志ID(关联APM_ALARM_LOG.ID)';
comment on column APM_ALARM_SEND.USER_ID
  is '发送用户ID(关联APM_USER.ID)';
comment on column APM_ALARM_SEND.SEND_TIME
  is '发送时间';
comment on column APM_ALARM_SEND.READ_FLAG
  is '已读标识(0：未读；1：已读)';
comment on column APM_ALARM_SEND.MESSAGE
  is '消息内容';
comment on column APM_ALARM_SEND.TITLE
  is '消息标题';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_ALARM_SEND
  add constraint APM_ALARM_SEND primary key (ID)
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