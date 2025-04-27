# TODO

## 模型与实物匹配

![RVIZ](https://github.com/whsleep/r550_gazebo/blob/main/picture/rviz.png)

雷达位置与实物不匹配。

## ~~ gazebo自定义控制器问题 ~~ 
两个文件，生成共享库`libr550_force_based_move.so`

在`\xacro\r550.gazebo`中使用

```xml
<gazebo>
  <plugin name="libr550_force_based_move" filename="libr550_force_based_move.so">
    <commandTopic>cmd_vel</commandTopic>
    <odometryTopic>odom</odometryTopic>
    <odometryFrame>odom</odometryFrame>
    <odometryRate>25.0</odometryRate>
    <robotBaseFrame>base_footprint</robotBaseFrame>
    <cmdVelTimeOut>0.25</cmdVelTimeOut>
    <publishOdometryTf>true</publishOdometryTf>
    <yaw_velocity_p_gain>1.0</yaw_velocity_p_gain>
    <x_velocity_p_gain>1500.0</x_velocity_p_gain>
    <y_velocity_p_gain>1500.0</y_velocity_p_gain>
    <max_x_velocity>0.6</max_x_velocity>
    <max_y_velocity>0.6</max_y_velocity>
    <max_yaw_velocity>0.5</max_yaw_velocity>
  </plugin>
</gazebo>
```
文件
`r550_force_based_move.h`
`r550_force_based_move.cpp`
和上述代码均可能存在问题。
具体 [GIF](https://github.com/whsleep/r550_gazebo/blob/main/picture/gzebo.gif)

## 使用新的麦克纳姆底盘控制器
[gazebo_mecanum_plugins](https://github.com/qaz9517532846/gazebo_mecanum_plugins/tree/ros1-noetic)

暂时无法正常运行
## 待添加IMU插件