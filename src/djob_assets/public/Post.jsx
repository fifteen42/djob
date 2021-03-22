import djob from 'ic:canisters/djob';
import * as React from 'react';
import { render } from 'react-dom';
import Drawer from 'antd/es/drawer';
import Form from 'antd/es/form';
import Select from 'antd/es/select';
import Row from 'antd/es/row';
import Col from 'antd/es/col';
import Button from 'antd/es/button';
import Input from 'antd/es/input';
import InputNumber from 'antd/es/input-number';
import 'antd/lib/drawer/style';
import 'antd/lib/form/style';
import 'antd/lib/select/style';
import 'antd/lib/row/style';
import 'antd/lib/col/style';
import 'antd/lib/table/style';
import 'antd/lib/tag/style';
import 'antd/lib/button/style';
import 'antd/lib/input/style';
import 'antd/lib/input-number/style';

const { Option } = Select;

export default class Post extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            jobs: [],
            post_visible: false,
        };
    }

    componentWillReceiveProps(nextProps) {
        this.setState({post_visible: nextProps.post_visible});
    }

    onClose = () => {
        console.log(1);
        this.setState({
            post_visible: false,
        });
    }

    render() {
        
        return (
            <>
            <Drawer
              title="Post a job"
              width={720}
              onClose={this.onClose}
              visible={this.state.post_visible}
              bodyStyle={{ paddingBottom: 80 }}
              footer={
                <div
                  style={{
                    textAlign: 'right',
                  }}
                >
                  <Button onClick={this.onClose} style={{ marginRight: 8 }}>
                    Cancel
                  </Button>
                  <Button onClick={this.onClose} type="primary">
                    Submit
                  </Button>
                </div>
              }
            >
            <Form layout="vertical" hideRequiredMark>
                <Row gutter={16}>
                  <Col span={12}>
                    <Form.Item
                      name="title"
                      label="Title"
                      rules={[{ required: true, message: 'Please enter job title' }]}
                    >
                      <Input placeholder="Please enter job title" />
                    </Form.Item>
                  </Col>
                  <Col span={12}>
                    <Form.Item
                      name="company"
                      label="Company"
                      rules={[{ required: true, message: 'Please enter company name' }]}
                    >
                      <Input
                        style={{ width: '100%' }}
                        placeholder="Please enter company name"
                      />
                    </Form.Item>
                  </Col>
                </Row>
                <Row gutter={16}>
                  <Col span={12}>
                    <Form.Item
                      name="location"
                      label="Location"
                      rules={[{ required: true, message: 'Please enter your location' }]}
                    >
                      <Input
                        style={{ width: '100%' }}
                        placeholder="Please enter your location"
                      />
                    </Form.Item>
                  </Col>
                  <Col span={4}>
                    <Form.Item
                      name="tag1"
                      label="Tag 1"
                      rules={[{ required: false}]}
                    >
                     <Input
                        placeholder="Tag 1"
                      />
                    </Form.Item>
                  </Col>
                  <Col span={4}>
                    <Form.Item
                      name="tag2"
                      label="Tag 2"
                      rules={[{ required: false}]}
                    >
                     <Input
                        placeholder="Tag 2"
                      />
                    </Form.Item>
                  </Col>
                  <Col span={4}>
                    <Form.Item
                      name="tag3"
                      label="Tag 3"
                      rules={[{ required: false}]}
                    >
                     <Input
                        placeholder="Tag 3"
                      />
                    </Form.Item>
                  </Col>
                </Row>
                <Row gutter={16}>
                  <Col span={12}>
                    <Form.Item
                      name="Email"
                      label="email"
                      rules={[{ required: true, }]}
                    >
                      <Input
                        placeholder="Please enter the email"
                      />
                    </Form.Item>
                  </Col>
                  <Col span={6}>
                    <Form.Item
                      name="salaryFloor"
                      label="Salary Floor"
                      rules={[{ required: true, }]}
                    >
                      <InputNumber
                         style={{ width: '100%' }}
                         defaultValue={1000}
                      />
                    </Form.Item>
                  </Col>
                  <Col span={6}>
                    <Form.Item
                      name="salaryCeiling"
                      label="Salary Ceiling"
                      rules={[{ required: true, }]}
                    >
                      <InputNumber
                         style={{ width: '100%' }}
                         defaultValue={10000}
                      />
                    </Form.Item>
                  </Col>
                </Row>
                <Row gutter={16}>
                  <Col span={24}>
                    <Form.Item
                      name="description"
                      label="Description"
                      rules={[
                        {
                          required: true,
                          message: 'please enter description',
                        },
                      ]}
                    >
                      <Input.TextArea rows={4} placeholder="please enter description" />
                    </Form.Item>
                  </Col>
                </Row>
              </Form>
              </Drawer>
            </>
        );
    }
}

