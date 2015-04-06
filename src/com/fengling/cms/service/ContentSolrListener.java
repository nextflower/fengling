package com.fengling.cms.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fengling.cms.entity.main.Content;
import com.fengling.cms.lucene.SolrContentSvc;

@Component
public class ContentSolrListener implements ContentListener{
	
	/**
	 * 是否已审核
	 */
	private static final String IS_CHECKED = "isChecked";

	public void preSave(Content content) {
		// TODO Auto-generated method stub
	}

	public void afterSave(Content content) {
		if (content.isChecked()) {
			solrContentSvc.createIndex(content);
		}
	}

	public Map<String, Object> preChange(Content content) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(IS_CHECKED, content.isChecked());
		return map;
	}

	public void afterChange(Content content, Map<String, Object> map) {
		boolean pre = (Boolean) map.get(IS_CHECKED);
		boolean curr = content.isChecked();
		if (pre && !curr) {
			solrContentSvc.deleteIndex(content);
		} else {
			solrContentSvc.createIndex(content);
		}
	}

	public void preDelete(Content content) {
		// TODO Auto-generated method stub
	}

	public void afterDelete(Content content) {
		solrContentSvc.deleteIndex(content);
	}
	
	@Autowired
	private SolrContentSvc solrContentSvc;
	
}
