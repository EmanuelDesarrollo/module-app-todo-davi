// Reexport the native module. On web, it will be resolved to ModuleAppTodoDaviModule.web.ts
// and on native platforms to ModuleAppTodoDaviModule.ts
export { default } from './ModuleAppTodoDaviModule';
export { default as ModuleAppTodoDaviView } from './ModuleAppTodoDaviView';
export { default as AvatarView } from './AvatarView';
export * from './ModuleAppTodoDavi.types';
