package com.fengling.core.dao;

import com.fengling.common.hibernate3.Updater;
import com.fengling.core.entity.DbFile;

public interface DbFileDao {
	public DbFile findById(String id);

	public DbFile save(DbFile bean);

	public DbFile updateByUpdater(Updater<DbFile> updater);

	public DbFile deleteById(String id);
}