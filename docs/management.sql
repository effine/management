 
create table t_auth  (
   orgcode              VARCHAR(32)                    not null,
   remark               VARCHAR(128),
   contactman           VARCHAR(32)                    not null,
   contacttel           VARCHAR(32)                    not null,
   filename             VARCHAR(32),
   fileremark           VARCHAR(128),
   authno               VARCHAR(32)                    not null,
   usercode             VARCHAR(32)                    not null,
   feedback             CHAR(1)                         not null	comment '0 - 未反馈 ， 1 - 已反馈',
   constraint PK_T_AUTH primary key (authno)
);
  

create table t_en_inv  ( 
   orgcode              VARCHAR(32)                    not null,
   invregnum            VARCHAR(32)                    not null,
   regcap               int                       not null,
   scale                int                       not null,
   constraint PK_T_EN_INV primary key (orgcode, invregnum)
);
 
create table t_enterprise  (
   orgcode              VARCHAR(32)                    not null,
   regno                VARCHAR(32)                    not null,
   cnname               VARCHAR(64)                    not null,
   enname               VARCHAR(64),
   contactman           VARCHAR(32),
   contacttel           VARCHAR(32),
   regcap              	INT                       not null,
   outregcap            int                       not null,
   regcry               CHAR(3)                         not null,
   usercode             VARCHAR(32)                    not null,
   regdate              CHAR(10)                        not null,
   constraint PK_T_ENTERPRISE primary key (orgcode)
);


create table t_invest  (
   invregnum            VARCHAR(32)                    not null,
   invname              VARCHAR(32)                    not null,
   cty                  CHAR(3)                         not null	comment '000 - 中国， 001-美国, 002-英国 , 003-日本',
   orgcode              VARCHAR(32),
   contactman           VARCHAR(32),
   contacttel           VARCHAR(32),
   email                VARCHAR(32),
   remark               VARCHAR(128),
   usercode             VARCHAR(32)                    not null,
   regdate              CHAR(10)                        not null,
   constraint PK_T_INVEST primary key (invregnum)
);


create table t_user  (
   usercode             VARCHAR(32)                    not null,
   username             VARCHAR(32)                    not null,
   orgtype              CHAR(1)                         not null	comment	'0 - 外汇管理局， 1 - 银行',
   userpswd             VARCHAR(32)                    not null,
   regdate              CHAR(19)                        not null,
   constraint PK_T_USER primary key (usercode)
);
