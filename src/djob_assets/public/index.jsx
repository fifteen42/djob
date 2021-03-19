import djob from 'ic:canisters/djob';
import * as React from 'react';
import { render } from 'react-dom';
import Table from 'antd/es/table';
import Tag from 'antd/es/tag';
import Row from 'antd/es/row';
import Col from 'antd/es/col';
import Button from 'antd/es/button';
import Input from 'antd/es/input';
import Space from 'antd/es/space';
import 'antd/lib/row/style';
import 'antd/lib/col/style';
import 'antd/lib/table/style';
import 'antd/lib/tag/style';
import 'antd/lib/button/style';
import 'antd/lib/input/style';
import 'antd/lib/space/style';
import './index.css';


class MyHello extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        jobs: []
    };
  }

  async componentWillMount() {
      const jobs = await djob.getAll();
      this.setState({...this.state, jobs: jobs});
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
        {
          title: 'Action',
          key: 'action',
          render: () => (
            <Space size="middle">
              <a>Update</a>
              <a onClick = {onDelete} >Delete</a>
            </Space>
          ),
        },
    ];


    const data = this.state.jobs;

    data.forEach( item => {
        item.salary = item.salaryFloor + "-" + item.salaryCeiling;
        item.key = item.id;
    });

    async function onDelete() {
        console.log("delete a job");
        await djob.delete(1);
    }

    const onSearch = value => console.log(value);

    const { Search } = Input;

    return (
        <>
            <Row>
                <Col span={24}>
                    <h2>
                    Djob: A decentralized job infomation sharing platform based on ICP (Dfinity)
                    </h2>
                </Col>
            </Row>
            <Row>
            <Col span={11}></Col>
            <Col span={4}>
                <Button type="primary" className='postbutton' size="large" >Post a Job</Button>
            </Col>
            <Col span={9}></Col>
            </Row>
            <Row>
                <Col span={8}></Col>
                <Col span={8}>
                    <Search className="search_input" placeholder="搜索标签、地点、工作名等" allowClear onSearch={onSearch} enterButton />
                </Col>
                <Col span={8}></Col>
            </Row>
            <Row>
                <Col span={2}></Col>
                <Col span={20}>
                    <Table columns={columns} dataSource={data} />
                </Col>
                <Col span={2}></Col>
            </Row>
        </> 
    );
  }
}

render(<MyHello />, document.getElementById('app'));