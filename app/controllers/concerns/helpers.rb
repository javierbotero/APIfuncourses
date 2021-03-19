module Helpers
  def is_user_receiver_or_sender(friendship)
    user = User.find(params[:current_user_id])
    user.id == friendship.sender_id || user.id == friendship.receiver_id ? true : false
  end

  def is_user_receiver_id(friendship)
    user = User.find(params[:current_user_id])
    friendship.receiver_id == @user.id ? true : false
  end

  def match_user_ids(id)
    params[:current_user_id].to_i == id
  end

  def course_to_info(courses)
    courses_student = []
    courses.each do |c|
      courses_student.push({
        id: c.id,
        title: c.title,
        content: c.content,
        favorites: c.favorites
      })
    end
    courses_student
  end

  def comments_info(comments)
    result = []
    comments.each do |c|
      result.push({
        user_id: c.user_id,
        course_id: c.course_id,
        body: c.body,
        course: {
          title: c.course.title
        }
      })
    end
    result
  end

  def new_friend_filtered(user)
    {
      id: user.id,
      status: user.status,
      email: user.email,
      username: user.username,
      courses_as_student: course_to_info(user.courses_as_student),
      courses: course_to_info(user.courses),
      comments: comments_info(user.comments.includes(:course)),
    }
  end
end