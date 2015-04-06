package com.fengling.search.solrmodule.query;

import com.fengling.search.solrmodule.condition.SolrSearchCondition;
import com.fengling.search.solrmodule.page.SolrResult;


/**
 * Solr检索逻辑处理接口
 * 		新增索引、更新索引、删除索引、清空索引、解析查询对象
 * @author wz
 *
 */
public interface EPSSolrServer {
	
	/**
	 * 获取索引库中符合条件的总记录数
	 * @return
	 */
	Integer getTotalCount();
	
	/**
	 * 查询并返回
	 * @param condition
	 * @return
	 */
	SolrResult query(SolrSearchCondition condition);
	
}
