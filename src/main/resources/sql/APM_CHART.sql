-- Create table
create table APM_CHART
(
  ID          NUMBER not null,
  CREATE_TIME DATE,
  SERVICE_ID  NUMBER,
  CPU         VARCHAR2(10),
  MEM         NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on table APM_CHART
  is '图表统计表';
comment on column APM_CHART.ID
  is 'id';
comment on column APM_CHART.CREATE_TIME
  is '创建时间';
comment on column APM_CHART.SERVICE_ID
  is '服务id';
comment on column APM_CHART.CPU
  is 'cpu';
comment on column APM_CHART.MEM
  is '内存';
-- Create/Recreate primary, unique and foreign key constraints 
alter table APM_CHART
  add constraint CHART_ID primary key (ID)
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