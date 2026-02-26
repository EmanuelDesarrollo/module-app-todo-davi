import { requireNativeView } from 'expo';
import * as React from 'react';

import { ModuleAppTodoDaviViewProps } from './ModuleAppTodoDavi.types';

const NativeView: React.ComponentType<ModuleAppTodoDaviViewProps> =
  requireNativeView('ModuleAppTodoDavi');

export default function ModuleAppTodoDaviView(props: ModuleAppTodoDaviViewProps) {
  return <NativeView {...props} />;
}
