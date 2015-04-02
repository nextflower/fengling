package com.fengling.core.dao.impl;

import org.springframework.stereotype.Repository;

import com.fengling.common.hibernate3.HibernateBaseDao;
import com.fengling.core.dao.CmsUserResumeDao;
import com.fengling.core.entity.CmsUserResume;

@Repository
public class CmsUserResumeDaoImpl extends HibernateBaseDao<CmsUserResume, Integer> implements CmsUserResumeDao {
	public CmsUserResume findById(Integer id) {
		CmsUserResume entity = get(id);
		return entity;
	}

	public CmsUserResume save(CmsUserResume bean) {
		getSession().save(bean);
		return bean;
	}
	
	@Override
	protected Class<CmsUserResume> getEntityClass() {
		return CmsUserResume.class;
	}
}