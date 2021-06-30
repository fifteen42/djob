import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as djob_idl, canisterId as djob_id } from 'dfx-generated/djob';

const agent = new HttpAgent();
const djob = Actor.createActor(djob_idl, { agent, canisterId: djob_id });

import * as React from 'react';
import { render } from 'react-dom';
import Table from 'antd/es/table';
import Tag from 'antd/es/tag';
import Row from 'antd/es/row';
import Col from 'antd/es/col';
import Button from 'antd/es/button';
import Input from 'antd/es/input';

import 'antd/lib/row/style';
import 'antd/lib/col/style';
import 'antd/lib/table/style';
import 'antd/lib/tag/style';
import 'antd/lib/button/style';
import 'antd/lib/input/style';
import 'antd/lib/space/style';
import '../assets/main.css';
import Post from "./Post.jsx"
// import Update from "./Update.jsx"


export default class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        jobs: [],
        post_visible: false,
        // update_visible: false,
    };
  }

  async componentWillMount() {
      const jobs = await djob.getAll();
      this.setState({...this.state, jobs: jobs});
  }

  // showUpdateDrawer = () => {
  //     console.log("udpate");
  //     this.setState({
  //         update_visible: true,
  //     });
  // }

  showPostDrawer = () => {
      this.setState({
          post_visible: true,
      });
  }

  async onSearch(value, event) {
    const search_res = await djob.search(value);
    this.setState({
        jobs: search_res
    });
  }

  render() {

    const columns = [
        {
          title: 'Title',
          dataIndex: 'title',
          key: 'title',
        //   render: text => <a>{text}</a>, 
        },
        {
          title: 'Company',
          dataIndex: 'company',
          key: 'company',
        },
        {
          title: 'Location',
          dataIndex: 'location',
          key: 'location',
        },
        {
            title: 'Salary',
            dataIndex: 'salary',
            key: 'salary',
        },
        {
          title: 'Tags',
          key: 'tag',
          dataIndex: 'tag',
          render: tag => (
            <>
              {tag.map(tag => {
                let color = tag.length > 5 ? 'geekblue' : 'green';
                if (tag === 'rust') {
                  color = 'volcano';
                }
                return (
                  <Tag color={color} key={tag}>
                    {tag.toUpperCase()}
                  </Tag>
                );
              })}
            </>
          ),
        },
        {
            title:'Email',
            key:'email',
            dataIndex:'email'
        },
        {
            title: 'Description',
            key:'description',
            dataIndex:'description'
        },
        // {
        //   title: 'Action',
        //   key: 'action',
        //   render: (row) => (
        //     <Space size="middle">
        //       <a onClick = {this.showUpdateDrawer} >Update</a>
        //       <a onClick = {() => {onDelete(row.key)}} >Delete</a>
        //     </Space>
        //   ),
        // },
    ];


    const data = this.state.jobs;

    data.forEach( item => {
        item.salary = item.salaryFloor + "-" + item.salaryCeiling;
        item.key = item.id.toString();
    });

    // bad way: sort by myself

    function compare(a, b) {
      if (a.key < b.key) {
        return -1;
      }
      if ( a.key > b.key ) {
        return 1;
      }
      return 0;
    }

    data.sort(compare);

    async function onDelete(id) {
        await djob.delete(parseInt(id));
        window.location.reload();
    }

    function refresh() {
      window.location.reload();
    }

    const { Search } = Input;

    return (
        <>
            <Row>
                <Col span={24}>
                    <h2>
                      <a onClick={refresh} style={{ color: '#24a0ed' }} >Djob</a> : A decentralized job infomation platform based on ICP (Dfinity).  <a href="https://github.com/FUTingFei/djob">Repo</a>
                    </h2>
                </Col>
            </Row>
            <Row>
            <Col span={11}></Col>
            <Col span={4}>
                <Button type="primary" className='postbutton' size="large" onClick={this.showPostDrawer} >Post a Job</Button>
            </Col>
            <Col span={9}></Col>
            </Row>
            <Row>
                <Col span={8}></Col>
                <Col span={8}>
                    <Search className="search_input" placeholder="搜索标签、地点、工作名等" allowClear onSearch={(value) => {this.onSearch(value)}} enterButton />
                </Col>
                <Col span={8}></Col>
            </Row>
            <Row>
                <Col span={2}></Col>
                <Col span={20}>
                    <Table columns={columns} dataSource={data}/>
                </Col>
                <Col span={2}></Col>
            </Row>
            <Post post_visible = {this.state.post_visible} ></Post>
            {/* <Update update_visible = {this.state.update_visible} ></Update> */}
        </> 
    );
  }
}

render(<Home />, document.getElementById('app'));