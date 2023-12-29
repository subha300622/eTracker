begin

insert into SAP_IMPLEM_STATUS_MASTER values (23,'QA-BTC Review');
insert into SAP_SUPPORT_STATUS_MASTER values (23,'QA-BTC Review');
insert into SAP_UPGRADE_STATUS_MASTER values (23,'QA-BTC Review');
insert into SAP_NONSAP_STATUS_LIST values (28,'QA-BTC Review');
insert into STATUS_MASTER values (20,'QA-BTC Review');

delete  from SAP_IMPLEM_STATUS_SUB where status_id=11;
delete  from SAP_SUPPORT_STATUS_SUB where status_id=11;
delete  from SAP_UPGRADE_STATUS_SUB where status_id=11;
delete  from STATUS_SUB where status_id=11;


insert into SAP_IMPLEM_STATUS_SUB values (11, 23);
insert into SAP_SUPPORT_STATUS_SUB values (11, 23);
insert into SAP_UPGRADE_STATUS_SUB values (11, 23);
insert into STATUS_SUB values (11,20);

insert into SAP_IMPLEM_STATUS_SUB values (23, 11);
insert into SAP_SUPPORT_STATUS_SUB values (23, 11);
insert into SAP_UPGRADE_STATUS_SUB values (23, 11);
insert into STATUS_SUB values (20, 11);

insert into SAP_IMPLEM_STATUS_SUB values (23, 12);
insert into SAP_SUPPORT_STATUS_SUB values (23, 12);
insert into SAP_UPGRADE_STATUS_SUB values (23, 12);
insert into STATUS_SUB values (20, 12);


insert into SAP_IMPLEM_STATUS_MASTER values (22,'Configuration Review');
insert into SAP_SUPPORT_STATUS_MASTER values (22,'Configuration Review');
insert into SAP_UPGRADE_STATUS_MASTER values (22,'Configuration Review');
insert into SAP_NONSAP_STATUS_LIST values (27,'Configuration Review');

insert into SAP_IMPLEM_STATUS_SUB values (22,16);
insert into SAP_SUPPORT_STATUS_SUB values (22,16);
insert into SAP_UPGRADE_STATUS_SUB values (22,16);

insert into SAP_IMPLEM_STATUS_SUB values (22,13);
insert into SAP_SUPPORT_STATUS_SUB values (22,13);
insert into SAP_UPGRADE_STATUS_SUB values (22,13);


insert into SAP_IMPLEM_STATUS_SUB values (22,14);
insert into SAP_SUPPORT_STATUS_SUB values (22,14);
insert into SAP_UPGRADE_STATUS_SUB values (22,14);

delete from SAP_IMPLEM_STATUS_SUB where status_id=13 and status =16;
delete from SAP_SUPPORT_STATUS_SUB where status_id=13 and status =16;
delete from SAP_UPGRADE_STATUS_SUB where status_id=13 and status =16;

insert into SAP_IMPLEM_STATUS_SUB values (13,22);
insert into SAP_SUPPORT_STATUS_SUB values (13,22);
insert into SAP_UPGRADE_STATUS_SUB values (13,22);

end;

