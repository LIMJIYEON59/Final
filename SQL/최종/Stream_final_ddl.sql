DROP TABLE "RANK";              --연결없음
DROP TABLE "ALARM";             --연결없음
DROP TABLE "SCHEDULE_REPLY";    --끼인테이블
DROP TABLE "REPLY";             --끼인테이블
DROP TABLE "FILES";             --끼인테이블
DROP TABLE "MEMBER_PROJECT";    --끼인테이블      
DROP TABLE "MEMBER_SCHEDULE";   --끼인테이블
DROP TABLE "CHATMEMBER";
DROP TABLE "ATTEND";           --ref USERS, WORKSTATE
DROP TABLE "WORKSTATE";     
DROP TABLE "CHATMESSAGE";
DROP TABLE "CHATROOM";
DROP TABLE "INFO";
DROP TABLE "SCHEDULE";          --ref USERS             
DROP TABLE "TASK";              --ref PROJECT, USERS
DROP TABLE "PROJECT";           --ref USERS
DROP TABLE "USERS";             --ref DEPT
DROP TABLE "DEPT";              --ref COMPANY
DROP TABLE "COMPANY";


DROP SEQUENCE schedule_sequence;
DROP SEQUENCE task_sequence;
DROP SEQUENCE project_sequence;
DROP SEQUENCE brestep_sequence;
DROP SEQUENCE replyrno_sequence;
DROP SEQUENCE company_sequence;
DROP SEQUENCE dept_sequence;

CREATE TABLE "COMPANY" (
	"CCODE"	VARCHAR2(10)		NOT NULL,
	"CNAME"	VARCHAR2(50)		NOT NULL,
	"CPHONE"	VARCHAR2(20)		NULL,
	"CADDRESS"	VARCHAR2(200)		NULL
);
COMMENT ON COLUMN "COMPANY"."CCODE" IS '회사코드';
COMMENT ON COLUMN "COMPANY"."CNAME" IS '회사명';
COMMENT ON COLUMN "COMPANY"."CPHONE" IS '회사전화번호';
COMMENT ON COLUMN "COMPANY"."CADDRESS" IS '회사주소';


CREATE TABLE "DEPT" (
	"DEPTNO"	VARCHAR2(10)		NOT NULL,
	"CCODE"	VARCHAR2(10)		NOT NULL,
	"DEPTNAME"	VARCHAR2(50)		NOT NULL
);
COMMENT ON COLUMN "DEPT"."DEPTNO" IS '부서번호';
COMMENT ON COLUMN "DEPT"."CCODE" IS '회사코드';
COMMENT ON COLUMN "DEPT"."DEPTNAME" IS '부서명';


CREATE TABLE "USERS" (
	"USERID"	VARCHAR2(50)		NOT NULL,
	"DEPTNO"	VARCHAR2(10)		NOT NULL,
	"CCODE"	VARCHAR2(10)		NOT NULL,
	"PASSWORD"	VARCHAR2(80)	DEFAULT 12345	NOT NULL,
	"ENABLED"	NUMBER(1)	DEFAULT 1	NOT NULL,
	"AUTHORITY"	VARCHAR2(10)	DEFAULT 'ROLE_M'	NOT NULL,
	"MNAME"	VARCHAR2(30)		NULL,
	"MPHONE"	VARCHAR2(20)		NULL,
	"MRANK"	VARCHAR2(40)		NULL
);
COMMENT ON COLUMN "USERS"."USERID" IS '이메일';
COMMENT ON COLUMN "USERS"."DEPTNO" IS '부서번호';
COMMENT ON COLUMN "USERS"."CCODE" IS '회사코드';
COMMENT ON COLUMN "USERS"."AUTHORITY" IS '관리자 ROLE_A, 사장 ROLE_C, 사원 ROLE_M';
COMMENT ON COLUMN "USERS"."MNAME" IS '이름';
COMMENT ON COLUMN "USERS"."MPHONE" IS '전화번호';
COMMENT ON COLUMN "USERS"."MRANK" IS '직급';


CREATE TABLE "PROJECT" (
	"PNO"	VARCHAR2(20)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"PNAME"	VARCHAR2(30)		NOT NULL,
	"PCONTENT"	VARCHAR2(300)		NULL,
	"PACCESS"	VARCHAR2(20)		NOT NULL,
	"PDATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PSTARTDATE"	DATE DEFAULT SYSDATE		NOT NULL,
	"PENDDATE"	DATE		NOT NULL,
	"PCOLOR"	VARCHAR2(15)	DEFAULT '#009b77'	NOT NULL,
	"PSTATUS"	VARCHAR2(20)	DEFAULT '미진행'	NOT NULL
);

COMMENT ON COLUMN "PROJECT"."PNO" IS '프로젝트번호';
COMMENT ON COLUMN "PROJECT"."USERID" IS 'EMAIL';
COMMENT ON COLUMN "PROJECT"."PNAME" IS '프로젝트명';
COMMENT ON COLUMN "PROJECT"."PCONTENT" IS '프로젝트설명';
COMMENT ON COLUMN "PROJECT"."PACCESS" IS '허용/불가';
COMMENT ON COLUMN "PROJECT"."PDATE" IS '작성날짜';
COMMENT ON COLUMN "PROJECT"."PSTARTDATE" IS '프로젝트시작날짜';
COMMENT ON COLUMN "PROJECT"."PENDDATE" IS '프로젝트끝날짜';
COMMENT ON COLUMN "PROJECT"."PCOLOR" IS '프로젝트 컬러';
COMMENT ON COLUMN "PROJECT"."PSTATUS" IS '진행중/완료/숨김..';


CREATE TABLE "TASK" (
	"TNO"	VARCHAR2(10)		NOT NULL,
	"PNO"	VARCHAR2(20)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"TMEMBER"	VARCHAR2(40)		NOT NULL,
    "TTITLE"	VARCHAR2(40)		NOT NULL,
	"TCONTENT"	CLOB		NOT NULL,
	"TSTATUS"	VARCHAR2(10)		NOT NULL,
	"TDATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"TSTARTDATE"	DATE DEFAULT SYSDATE		NOT NULL,
	"TENDDATE"	DATE		NOT NULL,
    "BREF" VARCHAR2(10)    NOT NULL,
    "BRESTEP" VARCHAR2(10) NOT NULL,
    "BRELEVEL"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "TASK"."TNO" IS '글번호';
COMMENT ON COLUMN "TASK"."PNO" IS '프로젝트번호';
COMMENT ON COLUMN "TASK"."USERID" IS '만든이EMAIL';
COMMENT ON COLUMN "TASK"."TMEMBER" IS 'EMAIL';
COMMENT ON COLUMN "TASK"."TTITLE" IS '글제목';
COMMENT ON COLUMN "TASK"."TCONTENT" IS '글내용';
COMMENT ON COLUMN "TASK"."TSTATUS" IS '진행도';
COMMENT ON COLUMN "TASK"."TDATE" IS '작성날짜';
COMMENT ON COLUMN "TASK"."TSTARTDATE" IS '시작일';
COMMENT ON COLUMN "TASK"."TENDDATE" IS '마감일';
COMMENT ON COLUMN "TASK"."BREF" IS 'TNO=BREF : 원본글, TNO <>BREF : 하위 업무';
COMMENT ON COLUMN "TASK"."BRESTEP" IS '1~N :하위 업무들의 순서, 0 : 원본글';
COMMENT ON COLUMN "TASK"."BRELEVEL" IS '0 :원본글,  1: 하위 업무';



CREATE TABLE "SCHEDULE" (
	"SNO"	VARCHAR2(10)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
    "PNO"	VARCHAR2(20)		NOT NULL,
	"SSTART"	DATE		NOT NULL,
	"SEND"	DATE		NOT NULL,
	"SPLACE"	VARCHAR2(50)		NULL,
	"SMEMO"	CLOB		NULL,
	"STITLE"	VARCHAR2(100)		NOT NULL,
	"SCOLOR"	VARCHAR2(7) 	NOT NULL
);

COMMENT ON COLUMN "SCHEDULE"."SNO" IS '일정번호';
COMMENT ON COLUMN "SCHEDULE"."USERID" IS '작성자(USERID)';
COMMENT ON COLUMN "SCHEDULE"."PNO" IS '프로젝트번호';
COMMENT ON COLUMN "SCHEDULE"."SSTART" IS '시작일시';
COMMENT ON COLUMN "SCHEDULE"."SEND" IS '종료일시';
COMMENT ON COLUMN "SCHEDULE"."SPLACE" IS '장소';
COMMENT ON COLUMN "SCHEDULE"."SMEMO" IS '일정내용';
COMMENT ON COLUMN "SCHEDULE"."STITLE" IS '일정명';
COMMENT ON COLUMN "SCHEDULE"."SCOLOR" IS '일정색상';

CREATE TABLE "SCHEDULE_REPLY" (
	"CRNO"	VARCHAR2(4)		NOT NULL,
	"SNO"	VARCHAR2(10)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"CRCONTENT"	VARCHAR2(300)		NULL,
	"CRDATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL
);

COMMENT ON COLUMN "SCHEDULE_REPLY"."CRNO" IS '댓글번호';

COMMENT ON COLUMN "SCHEDULE_REPLY"."SNO" IS '일정번호';

COMMENT ON COLUMN "SCHEDULE_REPLY"."USERID" IS 'EMAIL';

COMMENT ON COLUMN "SCHEDULE_REPLY"."CRCONTENT" IS '댓글내용';

CREATE TABLE "WORKSTATE" (
	"ATSTATENO"	NUMBER(1)		NOT NULL,
	"ATSTATE"	VARCHAR2(10)		NOT NULL
);
COMMENT ON COLUMN "WORKSTATE"."ATSTATENO" IS '근무상태번호';
COMMENT ON COLUMN "WORKSTATE"."ATSTATE" IS '근무상태';


CREATE TABLE "ATTEND" (
	"ATDATE"	VARCHAR2(20)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"ATSTATENO"	NUMBER(1)		NOT NULL,
	"ATINTIME"	VARCHAR2(25)		NOT NULL,
	"ATOUTTIME"	VARCHAR2(25)		NULL,
	"ATWORKHOUR"	NUMBER		NOT NULL
);
COMMENT ON COLUMN "ATTEND"."ATDATE" IS '출퇴근날짜';
COMMENT ON COLUMN "ATTEND"."USERID" IS 'EMAIL';
COMMENT ON COLUMN "ATTEND"."ATSTATENO" IS '근무상태번호';
COMMENT ON COLUMN "ATTEND"."ATINTIME" IS '출근시각';
COMMENT ON COLUMN "ATTEND"."ATOUTTIME" IS '퇴근시각';
COMMENT ON COLUMN "ATTEND"."ATWORKHOUR" IS '근무시간';

CREATE TABLE "MEMBER_SCHEDULE" (
	"SNO"	VARCHAR2(10)		NOT NULL,
	"ATTENDUSERID"	VARCHAR2(40)		NOT NULL
);

COMMENT ON COLUMN "MEMBER_SCHEDULE"."SNO" IS '일정번호';
COMMENT ON COLUMN "MEMBER_SCHEDULE"."ATTENDUSERID" IS '참석자(USERID)';



CREATE TABLE "MEMBER_PROJECT" (
	"PNO"	VARCHAR2(20)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL
);
COMMENT ON COLUMN "MEMBER_PROJECT"."PNO" IS '프로젝트번호';
COMMENT ON COLUMN "MEMBER_PROJECT"."USERID" IS 'EMAIL';


CREATE TABLE "FILES" (
	"FNAME"	VARCHAR2(100)		NOT NULL,
	"TNO"	VARCHAR2(10)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"FDATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"FSIZE"	NUMBER(10)		        NULL,
	"FPATH"	VARCHAR2(512)		    NULL,
	"FORIGINNAME"	VARCHAR2(120)	NULL
);
COMMENT ON COLUMN "FILES"."FNAME" IS '파일명';
COMMENT ON COLUMN "FILES"."TNO" IS '글번호';
COMMENT ON COLUMN "FILES"."USERID" IS 'EMAIL';
COMMENT ON COLUMN "FILES"."FDATE" IS '업로드일시';
COMMENT ON COLUMN "FILES"."FSIZE" IS '파일크기(단위byte)';
COMMENT ON COLUMN "FILES"."FPATH" IS '파일경로';
COMMENT ON COLUMN "FILES"."FORIGINNAME" IS '파일원본이름';


CREATE TABLE "REPLY" (
	"RNO"	VARCHAR2(4)		NOT NULL,
	"TNO"	VARCHAR2(10)		NOT NULL,
	"USERID"	VARCHAR2(40)		NOT NULL,
	"RCONTENT"	VARCHAR2(300)		NULL,
	"RDATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL
);
COMMENT ON COLUMN "REPLY"."TNO" IS '글번호';
COMMENT ON COLUMN "REPLY"."USERID" IS 'EMAIL';


CREATE TABLE "ALARM" (
	"ANO"	VARCHAR2(5)		NOT NULL,
	"ATYPE"	VARCHAR2(10)		NOT NULL,
	"REFNO"	NUMBER		NOT NULL,
	"ACONTENT"	VARCHAR2(50)		NOT NULL,
	"ADATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"ACHECK"	NUMBER(1)	DEFAULT 0	NOT NULL
);
COMMENT ON COLUMN "ALARM"."ATYPE" IS '업무,프로젝트,채팅,캘린더("MNO", "PNO")';
COMMENT ON COLUMN "ALARM"."REFNO" IS '35';


CREATE TABLE "RANK" (
	"MRANKNO"	NUMBER(1)		NOT NULL,
	"MRANK"	VARCHAR2(12)		NOT NULL
);
COMMENT ON COLUMN "RANK"."MRANKNO" IS '직급분류번호';
COMMENT ON COLUMN "RANK"."MRANK" IS '직급';





CREATE TABLE "CHATROOM"(
    "ROOMID" VARCHAR2(50) NOT NULL,
    "ROOMNAME"	VARCHAR2(30)	NOT NULL,
    "USERID"	VARCHAR2(40)	NOT NULL,
    "MNAME" VARCHAR2(30) NOT NULL
);
COMMENT ON COLUMN "CHATROOM"."ROOMID" IS '채팅방번호';
COMMENT ON COLUMN "CHATROOM"."ROOMNAME" IS '채팅방이름';
COMMENT ON COLUMN "CHATROOM"."USERID" IS 'ID';
COMMENT ON COLUMN "CHATROOM"."MNAME" IS '이름';

CREATE TABLE "CHATMESSAGE" (
	"ROOMID"	VARCHAR2(50)	NOT NULL,
	"USERID"	VARCHAR2(40)	NOT NULL,
	"MESSAGE"	VARCHAR2(300)	NOT NULL,
	"CDATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP NOT NULL,
    "MNAME" VARCHAR2(30) NOT NULL
);
COMMENT ON COLUMN "CHATMESSAGE"."USERID" IS 'ID';
COMMENT ON COLUMN "CHATMESSAGE"."MESSAGE" IS '내용';
COMMENT ON COLUMN "CHATMESSAGE"."CDATE" IS '작성 시간';
COMMENT ON COLUMN "CHATMESSAGE"."ROOMID" IS '채팅방번호';
COMMENT ON COLUMN "CHATMESSAGE"."MNAME" IS '이름';

CREATE TABLE "CHATMEMBER" (
	"ROOMID"	VARCHAR2(50)	NOT NULL,	
	"USERID"	VARCHAR2(40)	NOT NULL	
);
COMMENT ON COLUMN "CHATMEMBER"."ROOMID" IS '채팅방번호';
COMMENT ON COLUMN "CHATMEMBER"."ROOMID" IS 'USERID';




CREATE TABLE "INFO" (
	"INO"	VARCHAR2(10)	NOT NULL,
	"ITEXT"	CLOB	NOT NULL,
	"USERID"	VARCHAR2(50)	NOT NULL,
	"IDATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP NOT NULL,	
	"ITITLE"	VARCHAR2(80)	NOT NULL,
	"IWRITER"	VARCHAR2(30)	NOT NULL
);
COMMENT ON COLUMN "INFO"."INO" IS '공지번호';
COMMENT ON COLUMN "INFO"."ITEXT" IS '공지내용';
COMMENT ON COLUMN "INFO"."USERID" IS '이메일';
COMMENT ON COLUMN "INFO"."IDATE" IS '공지날짜';
COMMENT ON COLUMN "INFO"."ITITLE" IS '공지제목';
COMMENT ON COLUMN "INFO"."IWRITER" IS '작성자';






ALTER TABLE "USERS" ADD CONSTRAINT "PK_USERS" PRIMARY KEY (
	"USERID"
);

ALTER TABLE "RANK" ADD CONSTRAINT "PK_RANK" PRIMARY KEY (
	"MRANKNO"
);

ALTER TABLE "PROJECT" ADD CONSTRAINT "PK_PROJECT" PRIMARY KEY (
	"PNO"
);



ALTER TABLE "TASK" ADD CONSTRAINT "PK_TASK" PRIMARY KEY (
	"TNO"
);

ALTER TABLE "MEMBER_PROJECT" ADD CONSTRAINT "PK_MEMBER_PROJECT" PRIMARY KEY (
	"PNO",
	"USERID"
);




ALTER TABLE "REPLY" ADD CONSTRAINT "PK_REPLY" PRIMARY KEY (
	"RNO"
);

ALTER TABLE "ATTEND" ADD CONSTRAINT "PK_ATTEND" PRIMARY KEY (
	"ATDATE",
	"USERID"
);

ALTER TABLE "FILES" ADD CONSTRAINT "PK_FILES" PRIMARY KEY (
	"FNAME"
);

ALTER TABLE "DEPT" ADD CONSTRAINT "PK_DEPT" PRIMARY KEY (
	"DEPTNO",
	"CCODE"
);

ALTER TABLE "WORKSTATE" ADD CONSTRAINT "PK_WORKSTATE" PRIMARY KEY (
	"ATSTATENO"
);

ALTER TABLE "ALARM" ADD CONSTRAINT "PK_ALARM" PRIMARY KEY (
	"ANO"
);

ALTER TABLE "COMPANY" ADD CONSTRAINT "PK_COMPANY" PRIMARY KEY (
	"CCODE"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "PK_SCHEDULE" PRIMARY KEY (
	"SNO"
);
ALTER TABLE "SCHEDULE_REPLY" ADD CONSTRAINT "PK_SCHEDULE_REPLY" PRIMARY KEY (
	"CRNO"
);

ALTER TABLE "USERS" ADD CONSTRAINT "FK_DEPT_TO_USERS_1" FOREIGN KEY (
	"DEPTNO", "CCODE"
)
REFERENCES "DEPT" (
	"DEPTNO", "CCODE"
);

--ALTER TABLE "USERS" ADD CONSTRAINT "FK_DEPT_TO_USERS_2" FOREIGN KEY (
--	
--)
--REFERENCES "DEPT" (
--	
--);

ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_USERS_TO_PROJECT_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "TASK" ADD CONSTRAINT "FK_PROJECT_TO_TASK_1" FOREIGN KEY (
	"PNO"
    
)
REFERENCES "PROJECT" (
	"PNO"
);

ALTER TABLE "TASK" ADD CONSTRAINT "FK_USERS_TO_TASK_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "TASK" ADD CONSTRAINT "FK_USERS_TO_TASK_2" FOREIGN KEY (
	"TMEMBER"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "MEMBER_PROJECT" ADD CONSTRAINT "FK_PROJECT_TO_MEMBER_PROJECT_1" FOREIGN KEY (
	"PNO"
)
REFERENCES "PROJECT" (
	"PNO"
);

ALTER TABLE "MEMBER_PROJECT" ADD CONSTRAINT "FK_USERS_TO_MEMBER_PROJECT_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);



ALTER TABLE "REPLY" ADD CONSTRAINT "FK_TASK_TO_REPLY_1" FOREIGN KEY (
	"TNO"
)
REFERENCES "TASK" (
	"TNO"
);

ALTER TABLE "REPLY" ADD CONSTRAINT "FK_USERS_TO_REPLY_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "ATTEND" ADD CONSTRAINT "FK_USERS_TO_ATTEND_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "ATTEND" ADD CONSTRAINT "FK_WORKSTATE_TO_ATTEND_1" FOREIGN KEY (
	"ATSTATENO"
)
REFERENCES "WORKSTATE" (
	"ATSTATENO"
);

ALTER TABLE "MEMBER_SCHEDULE" ADD CONSTRAINT "PK_MEMBER_SCHEDULE" PRIMARY KEY (
	"SNO",
	"ATTENDUSERID"
);

ALTER TABLE "MEMBER_SCHEDULE" ADD CONSTRAINT "FK_SNO" FOREIGN KEY (
	"SNO"
)
REFERENCES "SCHEDULE" (
	"SNO"
);

ALTER TABLE "MEMBER_SCHEDULE" ADD CONSTRAINT "FK_ATTENDUSERID" FOREIGN KEY (
	"ATTENDUSERID"
)
REFERENCES "USERS" (
	"USERID"
);
ALTER TABLE "FILES" ADD CONSTRAINT "FK_TASK_TO_FILES_1" FOREIGN KEY (
	"TNO"
)
REFERENCES "TASK" (
	"TNO"
);

ALTER TABLE "FILES" ADD CONSTRAINT "FK_USERS_TO_FILES_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "DEPT" ADD CONSTRAINT "FK_COMPANY_TO_DEPT_1" FOREIGN KEY (
	"CCODE"
)
REFERENCES "COMPANY" (
	"CCODE"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "FK_USERS_TO_SCHEDULE_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "SCHEDULE_REPLY" ADD CONSTRAINT "FK_FROM_SCHEDULE_TO_1" FOREIGN KEY (
	"SNO"
)
REFERENCES "SCHEDULE" (
	"SNO"
);

ALTER TABLE "SCHEDULE_REPLY" ADD CONSTRAINT "FK_FROM_USERS_TO_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "FK_PROJECT_TO_SCHEDULE_1" FOREIGN KEY (
	"PNO"
)
REFERENCES "PROJECT" (
	"PNO"
);

ALTER TABLE "CHATROOM" ADD CONSTRAINT "PK_CHATROOM" PRIMARY KEY (
	"ROOMID"
);

ALTER TABLE "CHATMESSAGE" ADD CONSTRAINT "FK_CHATROOM_TO_CHATMESSAGE_1" FOREIGN KEY (
	"ROOMID"
)
REFERENCES "CHATROOM" (
	"ROOMID"
);

ALTER TABLE "CHATMESSAGE" ADD CONSTRAINT "FK_USERS_TO_CHATMESSAGE_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);
ALTER TABLE "CHATMEMBER" ADD CONSTRAINT "FK_USERS_TO_CHATMEMBER_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);
ALTER TABLE "CHATMEMBER" ADD CONSTRAINT "FK_CHATROOM_TO_CHATMEMBER_1" FOREIGN KEY (
	"ROOMID"
)
REFERENCES "CHATROOM" (
	"ROOMID"
);
ALTER TABLE "INFO" ADD CONSTRAINT "PK_INFO" PRIMARY KEY (
	"INO"
);

ALTER TABLE "INFO" ADD CONSTRAINT "FK_USERS_TO_INFO_1" FOREIGN KEY (
	"USERID"
)
REFERENCES "USERS" (
	"USERID"
);

-- view 추가
create view v_u_member_project
as
select PNO, USERID, MNAME, CCODE, DEPTNO
from member_project join users using(userid)
;
create view v_u_member_schedule
as
select SNO, ATTENDUSERID, MNAME as ATTENDNAME, CCODE, DEPTNO
from member_schedule join users on (ATTENDUSERID = USERID)
;

create view v_u_schedule
as
select s.*, u.mname, CCODE, DEPTNO
from schedule s join users u on (s.userid = u.userid)
;

commit;