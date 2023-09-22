package kh.groupware.stream.main.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kh.groupware.stream.project.model.vo.ProjectVo;
import kh.groupware.stream.ptask.model.vo.PtaskVo;

public interface MaintaskService {
	
	public List<ProjectVo> projectNameList();
	public List<PtaskVo> insertInnerTask(PtaskVo vo);
}