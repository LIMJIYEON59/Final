
package kh.groupware.stream.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.groupware.stream.project.model.service.ProjectService;
import kh.groupware.stream.project.model.service.ProjectServiceImpl;
import kh.groupware.stream.project.model.vo.ProjectVo;
import kh.groupware.stream.ptask.model.service.PtaskService;

@Controller
public class ProjectController {

	@Autowired
	private ProjectService projectService;
	
	@GetMapping("/projectlist")
	public String main() {
		return "projectList_ajax";
	}

	@GetMapping("/projectOne/{pno}")
	@ResponseBody
	public ProjectVo selectOne(@PathVariable("pno") String pno) {
		ProjectVo vo = projectService.selectOne(pno);
		return vo;
	}
	
	@GetMapping("/projectlist.ajax")
	@ResponseBody 
	public List<ProjectVo> insert() {
		List<ProjectVo> list = projectService.selectList();
		return list;
	}

	@PostMapping("/projectInsert")
	@ResponseBody
	public List<ProjectVo> insert(ProjectVo vo) {
		List<ProjectVo> add = projectService.insertList(vo);
		return add;
	}
	
	@GetMapping("/deleteList.ajax")
	@ResponseBody
	public Map<String, Object> delete(String pno) {
	    int deletedLists = projectService.deleteList(pno);
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("result", deletedLists);
	    map.put("pno", pno);
	    return map;
	}
	
	@GetMapping("/doUpdateProject")
	@ResponseBody
	public int update(ProjectVo vo) {
		int uvo = projectService.update(vo);
		return uvo;
		
	}
}
