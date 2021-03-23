import djob from 'ic:canisters/djob';
import * as React from 'react';
import { render } from 'react-dom';

export default class Update extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            jobs: []
        };
    }

    render() {
        
        return (
            <div>
                <h1>更新工作信息</h1>
            </div>
        );
    }
}

