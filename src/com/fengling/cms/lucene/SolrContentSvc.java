package com.fengling.cms.lucene;

import com.fengling.cms.entity.main.Content;

public interface SolrContentSvc {
	
	/**
	 * 创建索引
	 * 
	 * @param c
	 */
	public void createIndex(Content c);
	
	/**
	 * 删除索引
	 * 
	 * @param c
	 */
	public void deleteIndex(Content c);
	
	/**
	 * 更新索引
	 * @param c
	 */
	public void updateIndex(Content c);
	

}
