import launch
import launch_ros
from ament_index_python.packages import get_package_share_directory
from ament_index_python.packages import get_package_prefix
import os 
import xacro

def generate_launch_description():
    # 1. 获取功能包share目录（简化路径，避免冗余）
    urdf_package_path = get_package_share_directory('gazebo_sim_humble')
    default_urdf_path = os.path.join(urdf_package_path, 'xacro', 'robot_main.xacro')
    default_gazebo_world_path = os.path.join(urdf_package_path, 'world', 'museum.world')
    print(f"Xacro文件路径: {default_urdf_path}")  # 打印路径，方便调试

    # 2. 修正GAZEBO_MODEL_PATH：直接添加功能包share目录
    pkg_share = os.pathsep + os.path.join(get_package_prefix('gazebo_sim_humble'), 'share')
    if 'GAZEBO_MODEL_PATH' in os.environ:
        os.environ['GAZEBO_MODEL_PATH'] += pkg_share
    else:
        os.environ['GAZEBO_MODEL_PATH'] = "/usr/share/gazebo-11/models" + pkg_share
    print(os.environ['GAZEBO_MODEL_PATH'])

    # 3. 解析Xacro文件，生成机器人描述
    doc = xacro.parse(open(default_urdf_path))
    xacro.process_doc(doc)
    params = {'robot_description': doc.toxml()}

    # 4. 启动机器人状态发布节点（发布TF变换）
    node_robot_state_publisher = launch_ros.actions.Node(
        package='robot_state_publisher',
        executable='robot_state_publisher',
        output='screen',
        parameters=[params]
    )

    # 5. 在Gazebo中生成机器人实体
    spawn_entity = launch_ros.actions.Node(
        package='gazebo_ros', 
        executable='spawn_entity.py',
        arguments=['-topic', 'robot_description', '-entity', 'robot_gazebo'],
        output='screen'
    )

    # 6. 启动Gazebo并加载自定义世界
    action_launch_robot = launch.actions.IncludeLaunchDescription(
        launch.launch_description_sources.PythonLaunchDescriptionSource(
            os.path.join(get_package_share_directory('gazebo_ros'), 'launch', 'gazebo.launch.py')
        ),
        launch_arguments=[
            ('world', default_gazebo_world_path), 
            ('verbose', 'true')  # 打印详细日志，方便排查问题
        ]
    )

    # 7. 启动控制器：仅保留关节状态广播器（后续根据实际控制器补充）
    start_controllers = launch_ros.actions.Node(
        package="controller_manager",
        executable="spawner",
        arguments=[
            "joint_state_broadcaster",  # 必须启动，用于发布关节状态
            "mecanum_controller",   # 若为差速机器人，后续配置后取消注释
        ],
        output='screen'  # 打印控制器启动日志
    )

    # 8. 组装并返回Launch描述
    return launch.LaunchDescription([
        action_launch_robot,        # 1. 先启动Gazebo
        node_robot_state_publisher, # 2. 再发布机器人状态（TF）
        spawn_entity,               # 3. 在Gazebo中生成机器人
        start_controllers           # 4. 启动控制器（取消注释启用）
    ])