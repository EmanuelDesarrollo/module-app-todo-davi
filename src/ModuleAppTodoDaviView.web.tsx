import * as React from 'react';

import { ModuleAppTodoDaviViewProps } from './ModuleAppTodoDavi.types';

export default function ModuleAppTodoDaviView(props: ModuleAppTodoDaviViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
