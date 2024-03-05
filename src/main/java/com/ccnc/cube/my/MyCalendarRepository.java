package com.ccnc.cube.my;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MyCalendarRepository extends JpaRepository<MyCalendar, Integer>{

}
