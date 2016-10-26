-- Create table
create table APM_ALARM_LOG
(
  ID                NUMBER not null,
  ALARM_VALUE       NUMBER,
  ALARM_TIME        DATE,
  ALARM_TYPE        NUMBER(1),
  ALARM_SYSTEM_NAME VARCHAR2(50),
  ALARM_DESC        VARCHAR2(100)
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
comment on column APM_ALARM_LOG.ID
  is 'ID';
comment on column APM_ALARM_LOG.ALARM_VALUE
  is '报警指数';
comment on column APM_ALARM_LOG.ALARM_TIME
  is '报警时间';
comment on column APM_ALARM_LOG.ALARM_TYPE
  is '报警类型(1：CPU；2：内存；3：磁盘；4：网络)';
comment on column APM_ALARM_LOG.ALARM_SYSTEM_NAME
  is '系统名称';
comment on column APM_ALARM_LOG.ALARM_DESC
  is '详细描述信息';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_ALARM_LOG
  add constraint APM_ALARM_LOG primary key (ID)
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