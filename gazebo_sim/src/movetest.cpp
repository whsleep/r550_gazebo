#include <ros/ros.h>
#include <chrono>
#include <std_msgs/Bool.h>

#include "moving_cylinder.hpp"

using namespace std;

const uint8_t cylinder_num = 3;
int MovingCylinder::id_ = 0;
double T = 1.0;
double dt = 0.01;
double current_t = 0;

bool is_move = false;

void cmdCallback(const std_msgs::Bool::ConstPtr& cmd_move)
{
  is_move = cmd_move->data;
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "move_gazebo_model");
  ros::NodeHandle n("~");

  ros::Subscriber sub = n.subscribe<std_msgs::Bool>("/cmd_move", 10, cmdCallback);
  ros::ServiceClient client = n.serviceClient<gazebo_msgs::SetModelState>("/gazebo/set_model_state");
  gazebo_msgs::SetModelState set_model_state_srv;

  MovingCylinder cylinder[cylinder_num];
  geometry_msgs::Point init_pos[cylinder_num];
  geometry_msgs::Twist twist[cylinder_num];

  for (uint8_t i = 0; i < cylinder_num; i++)
  {
    n.param<double>("x" + to_string(i), init_pos[i].x, 5);
    n.param<double>("y" + to_string(i), init_pos[i].y, 5);
    n.param<double>("z" + to_string(i), init_pos[i].z, 0.25);
    n.param<double>("vx" + to_string(i), twist[i].linear.x, 0.0);
    n.param<double>("vy" + to_string(i), twist[i].linear.y, 0.0);

    cylinder[i].setPosition(init_pos[i]);
    cylinder[i].setVel(twist[i]);
  }

  while (ros::ok())
  {
    if (is_move)
    {
      current_t += dt;
      if(current_t >= T)
      {
        for (uint8_t i = 0; i < cylinder_num; i++){
            twist[i].linear.x = -twist[i].linear.x;
            twist[i].linear.y = -twist[i].linear.y;
            cylinder[i].setVel(twist[i]);
        }
      current_t = 0;
      }
      
      for (uint8_t i = 0; i < cylinder_num; i++)
        cylinder[i].updateState(dt);
    }

    for (uint8_t i = 0; i < cylinder_num; i++)
    {
      set_model_state_srv.request.model_state = cylinder[i].model_state_;
      client.call(set_model_state_srv);
    }

    ros::spinOnce();
    ros::Duration(dt).sleep();
  }
  return 0;
}
