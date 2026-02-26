import { requireNativeView } from 'expo';
import * as React from 'react';

import { AvatarViewProps } from './ModuleAppTodoDavi.types';

const NativeAvatarView: React.ComponentType<AvatarViewProps> =
  requireNativeView('AvatarView');

export default function AvatarView(props: AvatarViewProps) {
  return <NativeAvatarView {...props} />;
}
