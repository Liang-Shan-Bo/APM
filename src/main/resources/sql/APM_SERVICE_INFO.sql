-- Create table
create table APM_SERVICE_INFO
(
  ID                  NUMBER not null,
  SERVICE_NAME        VARCHAR2(50) not null,
  SERVICE_ADDRESS     VARCHAR2(15) not null,
  SERVICE_PORT        VARCHAR2(5) not null,
  MONITOR_PORT        VARCHAR2(5) not null,
  CPU_AVAILABLE_COUNT NUMBER default 0,
  SYSTEM_NAME         VARCHAR2(50) default '',
  SYSTEM_ARCH         VARCHAR2(50) default '',
  SYSTEM_VERSION      VARCHAR2(50) default '',
  JVM_VENDOR          VARCHAR2(50) default '',
  JVM_NAME            VARCHAR2(50) default '',
  JVM_VERSION         VARCHAR2(50) default '',
  NORM_ID             NUMBER not null,
  ALARM_POLICY_ID     NUMBER not null,
  SERVICE_USER_NAME   VARCHAR2(50),
  SERVICE_PASSWORD    VARCHAR2(50),
  STARTUP_PATH        VARCHAR2(100),
  SHUTDOWN_PATH       VARCHAR2(100),
  DELETE_FLAG         NUMBER(1) not null
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
comment on column APM_SERVICE_INFO.ID
  is '服务ID';
comment on column APM_SERVICE_INFO.SERVICE_NAME
  is '服务名称';
comment on column APM_SERVICE_INFO.SERVICE_ADDRESS
  is '服务IP地址';
comment on column APM_SERVICE_INFO.SERVICE_PORT
  is '服务端口号';
comment on column APM_SERVICE_INFO.MONITOR_PORT
  is '服务监控端口号';
comment on column APM_SERVICE_INFO.CPU_AVAILABLE_COUNT
  is 'CPU数量';
comment on column APM_SERVICE_INFO.SYSTEM_NAME
  is '系统名称';
comment on column APM_SERVICE_INFO.SYSTEM_ARCH
  is '系统架构';
comment on column APM_SERVICE_INFO.SYSTEM_VERSION
  is '系统版本';
comment on column APM_SERVICE_INFO.JVM_VENDOR
  is '虚拟机供应商';
comment on column APM_SERVICE_INFO.JVM_NAME
  is '虚拟机名称';
comment on column APM_SERVICE_INFO.JVM_VERSION
  is '虚拟机版本';
comment on column APM_SERVICE_INFO.NORM_ID
  is '指标ID(关联APM_NORM.ID)';
comment on column APM_SERVICE_INFO.ALARM_POLICY_ID
  is '策略ID(关联APM_ALARM_POLICY.ID)';
comment on column APM_SERVICE_INFO.SERVICE_USER_NAME
  is '登录系统用户名';
comment on column APM_SERVICE_INFO.SERVICE_PASSWORD
  is '登录系统用户口令';
comment on column APM_SERVICE_INFO.STARTUP_PATH
  is '启动脚本路径';
comment on column APM_SERVICE_INFO.SHUTDOWN_PATH
  is '关闭脚本路径';
comment on column APM_SERVICE_INFO.DELETE_FLAG
  is '是否可删除标识(0:不可删除；1:可删除)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_SERVICE_INFO
  add constraint APM_SERVICE_INFO primary key (ID)
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