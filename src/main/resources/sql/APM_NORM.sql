-- Create table
create table APM_NORM
(
  ID           NUMBER not null,
  NORM_NAME    VARCHAR2(50) not null,
  NORM_TYPE    NUMBER(1) default 0,
  NORM_NORMAL  NUMBER default 0,
  NORM_WARNING NUMBER default 0,
  NORM_DANGER  NUMBER default 0,
  SERVICE_TYPE NUMBER(1) not null,
  DELETE_FLAG  NUMBER(1) not null
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
comment on column APM_NORM.NORM_NAME
  is '指标名称';
comment on column APM_NORM.NORM_TYPE
  is '指标类型(1：CPU；2：内存；3：网络；4：磁盘)';
comment on column APM_NORM.NORM_NORMAL
  is '正常指标';
comment on column APM_NORM.NORM_WARNING
  is '警告指标';
comment on column APM_NORM.NORM_DANGER
  is '过高指标';
comment on column APM_NORM.SERVICE_TYPE
  is '系统类型(1:服务指标；2:系统指标)';
comment on column APM_NORM.DELETE_FLAG
  is '是否可删除标识(0:不可删除；1:可删除)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_NORM
  add constraint APM_NORM primary key (ID)
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