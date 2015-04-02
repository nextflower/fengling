package com.fengling.cms.dao.main.impl;

import org.springframework.stereotype.Repository;

import com.fengling.cms.dao.main.ChannelExtDao;
import com.fengling.cms.entity.main.ChannelExt;
import com.fengling.common.hibernate3.HibernateBaseDao;

@Repository
public class ChannelExtDaoImpl extends HibernateBaseDao<ChannelExt, Integer>
		implements ChannelExtDao {
	public ChannelExt save(ChannelExt bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	protected Class<ChannelExt> getEntityClass() {
		return ChannelExt.class;
	}
}