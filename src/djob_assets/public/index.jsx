import djob from 'ic:canisters/djob';
import * as React from 'react';
import { render } from 'react-dom';
import { Table, Tag, Space } from 'antd';
import Table from 'antd/es/table';
import Tag from 'antd/es/tag';
import Space from 'antd/es/space';
import 'antd/lib/table/style';
import 'antd/lib/tag/style';
import 'antd/lib/space/style';


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
        }
        // {
        //   title: 'Action',
        //   key: 'action',
        //   render: (text, record) => (
        //     <Space size="middle">
        //       <a>Invite {record.name}</a>
        //       <a>Delete</a>
        //     </Space>
        //   ),
        // },
    ];


    const data = this.state.jobs;

    data.forEach( item => {
        item.salary = item.salaryFloor + "-" + item.salaryCeiling;
    });

    return (
        <Table columns={columns} dataSource={data} />
    );
  }
}

render(<MyHello />, document.getElementById('app'));