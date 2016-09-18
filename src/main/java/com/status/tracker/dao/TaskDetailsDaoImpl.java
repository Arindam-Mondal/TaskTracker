package com.status.tracker.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import com.status.tracker.model.CommentsDetails;
import com.status.tracker.model.TaskDescription;
import com.status.tracker.model.TaskDetails;
import com.status.tracker.model.TaskInfo;

public class TaskDetailsDaoImpl implements TaskDetailsDao {

	private static final Logger logger = LoggerFactory.getLogger(TaskDetailsDaoImpl.class);

	private SessionFactory sessionFactory;

	private DataSource dataSource;

	private JdbcTemplate jdbcTemplateObject;

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		this.jdbcTemplateObject = new JdbcTemplate(dataSource);
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void addTask(TaskDetails taskDetails, TaskDescription taskDescription) {

		Session session = this.sessionFactory.getCurrentSession();
		String sql = "select max(taskid) from TaskDetails";
		Query q = session.createQuery(sql);
		List taskidlist = q.list();
		if (null == taskidlist.get(0)) {
			taskDetails.setTaskid("TASK1001");
			taskDescription.setTaskid(taskDetails.getTaskid());

		} else {
			int id = Integer.parseInt(taskidlist.get(0).toString().substring(4));
			id = id + 1;
			String taskid = "TASK" + id;
			taskDetails.setTaskid(taskid);
			taskDescription.setTaskid(taskDetails.getTaskid());
		}
		try {

			session.save(taskDetails);
			session.save(taskDescription);
			session.flush();

		} catch (Exception e) {
			logger.error(e.getMessage());
		}

	}

	@Override
	public List<TaskInfo> searchTask(String keyword) {
		Session session = this.sessionFactory.getCurrentSession();
		String hql = "from TaskDetails as tdtl, TaskDescription as tdesc where lower(tdtl.taskname) like :keyword"
				+ " and tdtl.taskid = tdesc.taskid";
		Query query = session.createQuery(hql);
		query.setParameter("keyword", "%" + keyword + "%");
		List<Object> results = query.list();

		List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
		Iterator itr = results.iterator();
		while (itr.hasNext()) {
			Object[] obj = (Object[]) itr.next();
			TaskInfo taskInfo = new TaskInfo();
			for (int i = 0; i < obj.length; i++) {
				if ((obj[i]) instanceof TaskDetails) {
					taskInfo.setTaskDetails((TaskDetails) obj[i]);
				} else if ((obj[i]) instanceof TaskDescription) {
					taskInfo.setTaskDescription((TaskDescription) obj[i]);
				}
			}
			String hqlComments = "from CommentsDetails where taskid=:taskid order by created asc";
			Query queryComments = session.createQuery(hqlComments);
			queryComments.setParameter("taskid", taskInfo.getTaskDetails().getTaskid());
			List<CommentsDetails> comments = queryComments.list();

			taskInfo.setCommentsDetailsList(comments);

			taskInfoList.add(taskInfo);
		}
		return taskInfoList;

	}

	@Override
	public List<TaskInfo> displayTask(String userId) {

		Session session = this.sessionFactory.getCurrentSession();
		String hql = "from TaskDetails as tdtl, TaskDescription as tdesc where tdtl.userid=:userid and"
				+ " tdtl.taskid = tdesc.taskid";
		Query query = session.createQuery(hql);
		query.setParameter("userid", userId);
		List<Object> results = query.list();

		List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
		Iterator itr = results.iterator();
		while (itr.hasNext()) {
			Object[] obj = (Object[]) itr.next();
			TaskInfo taskInfo = new TaskInfo();
			for (int i = 0; i < obj.length; i++) {
				if ((obj[i]) instanceof TaskDetails) {
					taskInfo.setTaskDetails((TaskDetails) obj[i]);
				} else if ((obj[i]) instanceof TaskDescription) {
					taskInfo.setTaskDescription((TaskDescription) obj[i]);
				}
			}
			String hqlComments = "from CommentsDetails where taskid=:taskid order by created asc";
			Query queryComments = session.createQuery(hqlComments);
			queryComments.setParameter("taskid", taskInfo.getTaskDetails().getTaskid());
			List<CommentsDetails> comments = queryComments.list();

			taskInfo.setCommentsDetailsList(comments);

			taskInfoList.add(taskInfo);
		}

		return taskInfoList;

	}

	@Override
	public void addTask(String taskname, String userid, String status, String starttime, String endtime) {
		String Sql = "insert into taskDetails values(?,?,?,?,current_timestamp(),current_timestamp(),?,?)";
		jdbcTemplateObject.update(Sql, "TASK1002", taskname, userid, status, starttime, endtime);
		logger.info("task inserted succcessfully");

	}

	@Override
	public void addComments(CommentsDetails commentsDetails) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		try {
			session.save(commentsDetails);
			session.flush();
		} catch (Exception e) {
			throw new Exception(e);
		}

	}

	@Override
	public TaskInfo displaySingleTask(String userId, String taskId) {
		Session session = this.sessionFactory.getCurrentSession();
		String hql = "from TaskDetails as tdtl, TaskDescription as tdesc where tdtl.userid=:userid and"
				+ " tdtl.taskid=:taskid and tdtl.taskid = tdesc.taskid";
		Query query = session.createQuery(hql);
		query.setParameter("userid", userId);
		query.setParameter("taskid", taskId);
		Object resultObject = query.uniqueResult();
		Object[] obj = (Object[]) resultObject;

		TaskInfo taskInfo = new TaskInfo();
		for (int i = 0; i < obj.length; i++) {
			if ((obj[i]) instanceof TaskDetails) {
				taskInfo.setTaskDetails((TaskDetails) obj[i]);
			} else if ((obj[i]) instanceof TaskDescription) {
				taskInfo.setTaskDescription((TaskDescription) obj[i]);
			}
		}
		String hqlComments = "from CommentsDetails where taskid=:taskid order by created asc";
		Query queryComments = session.createQuery(hqlComments);
		queryComments.setParameter("taskid", taskInfo.getTaskDetails().getTaskid());
		List<CommentsDetails> comments = queryComments.list();

		taskInfo.setCommentsDetailsList(comments);

		return taskInfo;

	}

	@Override
	public void editTask(TaskDetails task, TaskDescription desc) {
		Session session = this.sessionFactory.getCurrentSession();
		try {

			session.update(task);
			session.update(desc);
			session.flush();

		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}

}
