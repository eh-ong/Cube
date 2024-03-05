package com.ccnc.cube.common;

public class CommonEnum {
    public enum UserGender {
        남, 여
    }

    public enum UserStatus {
        활성화, 비활성화
    }

    public enum UserRole {
        USER, ADMIN
    }

    public enum UserPosition {
        팀원, 팀장
    }

    public enum MailReadStatus {
        읽지않음, 읽음
    }
    
    public enum MailIsDelete {
        존재, 삭제
    }
    
    public enum MailImportant {
        기본, 중요
    }

    public enum MrStatus {
        사용가능, 사용불가
    }

    public enum CarStatus {
        사용가능, 사용불가
    }

    public enum ReservationItem {
        회의실, 차량
    }

    public enum ApIsWeekend {
        주말, 평일
    }

    public enum ApType {
        연차, 공가, 오전반차, 오후반차, 정상근무
    }

    public enum ApStatus {
        대기중, 승인, 반려, 미등록
    }

    public enum AIsWeekend {
        주말, 평일
    }

    public enum AType {
        연차, 공가, 오전반차, 오후반차, 정상근무, 지각, 주말근무
    }

    public enum AStatus {
        대기중, 승인, 반려
    }
    
    public enum VaStatus {
    	대기중, 승인, 반려
    }
    
    public enum QnaStatus {
    	대기중, 답변완료
    }
    
    public enum PrStatus {
    	진행중, 완료, 중단
    }
}
